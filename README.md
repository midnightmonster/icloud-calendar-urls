# icloud-calendar-urls

Instantly list the CalDAV URLs of your iCloud calendars so you can add them to other calendar apps, like Thunderbird.

## Why?

I've been using Thunderbird for my email since it came out almost 20 years ago. It's not cutting edge or trendy, but it's reliable and fast even with a couple decades of archives, and I understand how it works.

On my iPhone, I just use Apple Mail, and calendar invites in email Just Work. On the desktop, though, it's not so convenient to send and accept invites when Apple Calendar (and Fantastical, which is what I actually use) want to send via Apple Mail, and for irritating historical reasons my iCloud address isn't even my normal email address.

Thunderbird's actual calendar UI is not nearly as lovely as Fantastical, but the invite handling works well if only you can hook it up to your actual calendar.

iCloud calendaring is based on CalDAV and completely compatible with Thunderbird, but Apple does not make it easy at all to find the secret CalDAV URL you need for each calendar. **This solves that problem.**

## Requirements

* A Mac desktop or laptop that has the iCloud calendars you want setup in the Apple Calendar app
* The ability to open `Terminal` and paste a command
* At least one of:
  * Some familiarity with any programming language so you can read the script and see it's safe
  * A friend with same
  * Blind trust in the kindness of a stranger on the Internet
  
## Usage

Paste this in the terminal:

```shell
curl -s https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls.rb | ruby
```

Or download [`icloud_calendar_urls.rb`](https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls.rb) and run it with:

```shell
ruby icloud_calendar_urls.rb
```

You'll get nice little report that looks something like this:

```markdown
iCloud (your-address@icloud.com)
================================

* Family 
  https://p12-caldav.icloud.com/586234577/calendars/b8e0edb4-1acd-445a-b20e-66a1bf964bb7/

* Work 
  https://p12-caldav.icloud.com/586234577/calendars/73C8CF6F-98A5-4D7F-9801-C987F5AC1529/

* A Really Old Calendar 
  https://p12-caldav.icloud.com/586234577/calendars/reallyold/

* Calendar Someone Shares With You (Sharer's Name)
  https://p12-caldav.icloud.com/586234577/calendars/b94b384039a761e70d632beb4373eb8d4cac0e06f4133f446b6bcc40b9e159a4/
```

Macs come with some version of ruby since quite a long time, and this short script uses only standard library modules that have been around for many years, so it should run on any modern-ish Mac. But I've only actually tried it on my own system, so your mileage may vary.
