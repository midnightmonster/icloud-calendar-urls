# icloud-calendar-urls

Instantly list the CalDAV URLs of your iCloud calendars so you can add them to other calendar apps, like Thunderbird. **Now updated for macOS Ventura!**

## Why?

Apple's iCloud calendars are based on CalDAV, and they're compatible with Thunderbird and most other calendar programs, if only you can find the secret CalDAV URL of each calendar. **This script makes that very easy.**

## Requirements

* A Mac desktop or laptop running macOS Ventura (or later?) with your iCloud calendars currently accessible in the Apple Calendar app
  * If you're running Monterey, follow these instructions and let me know if it works.
  * If it doesn't work or you have macOS before Monterey, see "Instructions for older macOS" at the bottom.
* The ability to open `Terminal` and paste a command
* At least one of:
  * Some familiarity with SQL (and maybe shell scripting) so you can read the short script and see it's safe
  * A friend with same
  * Blind trust in the kindness of a stranger on the Internet

## Permissions problem?

When you run one of the commands in **Usage** below, you may get some kind of permissions error. In that case, don't reach for `sudo`—it won't help. Try typing each of these:

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
curl -s https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls | bash
```

Or download [`icloud_calendar_urls`](https://raw.githubusercontent.com/midnightmonster/icloud-calendar-urls/master/icloud_calendar_urls) and run it with:


```shell
bash icloud_calendar_urls
```

You'll get a nice little report that looks something like this:

```markdown
iCloud Calendar URLs
====================
You'll need your iCloud email and password when you add these to your calendar app.

* your@email.com (Your Name)
  https://p12-caldav.icloud.com/586234577/calendars/inbox/

* Family (Your Name)
  https://p12-caldav.icloud.com/586234577/calendars/b8e0edb4-1acd-445a-b20e-66a1bf964bb7/

* Work (Your Name)
  https://p12-caldav.icloud.com/586234577/calendars/73C8CF6F-98A5-4D7F-9801-C987F5AC1529/

* A Really Old Calendar (Your Name)
  https://p12-caldav.icloud.com/586234577/calendars/reallyold/

* Calendar Someone Shares With You (Sharer's Name)
  https://p12-caldav.icloud.com/586234577/calendars/b94b384039a761e70d632beb4373eb8d4cac0e06f4133f446b6bcc40b9e159a4/
```

**I'm not sure if the calendars named only with your email address can actually be used** or what they contain. They didn't show up pre-Ventura.

## Instructions for Monterey

Neither script in this repository will work with Monterey. Last I looked, the data may be in a quite similar format to how it was in Big Sur, but `icloud_calendar_urls.rb` does not look in quite the right place. I do not currently have access to a machine running Monterey to fix it. Patches welcome.

## Instructions for Big Sur (and earlier?)

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

Macs come with some version of ruby since quite a long time, and this short script uses only standard library modules that have been around for many years, so it should run on your Mac. But I've only actually tried it on my own system, so your mileage may vary.
