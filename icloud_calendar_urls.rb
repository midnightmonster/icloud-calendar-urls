#!/usr/bin/env ruby

# Copyright (c) 2021 Joshua Paine
#
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'rexml/document'
require 'uri'

# Lazy Hash-style Plist access using only standard library
# Implements no more of Plist parsing or Hash interface than needed for this 
# task. This is not an efficient way to handle lots of XML, but unless you have
# thousands of calendars, it won't matter at all.
class PlistXML
  def self.from(path)
    File.open(path) do |f|
      self.new(f)
    end
  end

  def initialize(stream)
    @xml = REXML::Document.new(stream)
  end

  def values_at(*keys)
    keys.map {|k| self[k]}
  end

  def [](key)
    v = @xml.root.get_elements('//key[text() = "'+key.to_s+'")]').first.next_element
    case v.name
    when 'true' then true
    when 'false' then false
    when 'integer' then v.text.to_i
    when 'string' then v.text.to_s
    end
  rescue
    nil
  end
end

Dir.
  glob(Dir.home+"/Library/Calendars/*.caldav"). # Find config dirs of all server accounts
  map {|dir| [PlistXML.from("#{dir}/Info.plist"),dir] }. # Load plist, keeping track of dir
  select {|(spx,dir)| spx["Type"] == "CalDAV" && spx["Enabled"] }.
  sort_by {|(spx,dir)| spx["Order"] }.
  each do |(spx,dir)|
    url = URI(spx["PrincipalURL"])
    heading = "#{spx["Title"]} (#{spx["Login"]})"
    puts "\n" + heading + "\n" + ('=' * heading.length) + "\n"
    Dir.glob("#{dir}/*.calendar/Info.plist"). # Load plist of each calendar on this server
        map {|path| cpx = PlistXML.from(path) }.
        sort_by {|cpx| cpx["Order"] }.
        each do |cpx|
          (title,owner,cpath) = cpx.values_at("Title","OwnerDisplayName","CalendarPath")
          owner = (owner && !owner.empty?) ? "(#{owner})" : ""
          curl = url.dup.tap {|u| u.path = cpath}
          puts "\n* #{title} #{owner}\n  #{curl}\n"
        end
    puts "\n"
  end
