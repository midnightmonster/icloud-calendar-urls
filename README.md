# icloud-calendar-urls

Instantly list the CalDAV URLs of your iCloud calendars so you can add them to other calendar apps, like Thunderbird.

## Why?

Apple's iCloud calendars are based on CalDAV, and they're compatible with Thunderbird and most other calendar programs, if only you can find the secret CalDAV URL of each calendar. **This script makes that very easy.**

## Requirements

* A Mac desktop or laptop with your iCloud calendars currently accessible in the Apple Calendar app
* The ability to open `Terminal` and paste a command
* At least one of:
  * Some familiarity with any programming language so you can read the short script and see it's safe
  * A friend with same
  * Blind trust in the kindness of a stranger on the Internet

## Permissions problem?

When you run one of the commands in **Usage** below, you may get an error that includes something like this:
```
icloud_calendar_urls.rb:59:in `glob': Operation not permitted - /Users/USERNAME/Library/Calendars (Errno::EPERM)
```
In that case, don't reach for `sudo`—it won't help. Try typing each of these:
```
ls ~/Library
ls ~/Library/Calendars
```
...and see if Mac OS gives you some kind of prompt to allow access.

If that doesn't solve it, open 🍎 > System Preferences and go to "Security & Privacy". Then go to "Full Disk Access", click the lock to make changes, click the + button to add an application, and add Terminal. Thanks to @erickvd for [this tip](https://github.com/midnightmonster/icloud-calendar-urls/issues/1).

<img width="780" alt="Screen shot of Security & Privacy / Full Disk Access" src="https://user-images.githubusercontent.com/57948/161054592-a4590f02-c276-403f-a22a-13dde4e28bc7.png">

## Usage

Paste this in the terminal:

```shell
curl -s https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls.rb | ruby
```

Or download [`icloud_calendar_urls.rb`](https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls.rb) and run it with:

```shell
ruby icloud_calendar_urls.rb
```

You'll get a nice little report that looks something like this:

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
