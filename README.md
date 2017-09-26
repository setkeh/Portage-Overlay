# Layman-Overlay
Gentoo Layman Overlay


Usage:
====
Add this to `/etc/portage/repos.conf/setkeh-overlay.conf`.

```
[setkeh-overlay]
location   = /usr/local/overlay/setkeh-overlay
sync-type  = git
sync-uri   = https://github.com/setkeh/Layman-Overlay.git
auto-sync  = yes
```

`/usr/local/overlay` doesn't exist by default so create it if needed.
```
[ ! -d /usr/local/overlay ] && mkdir -p /usr/local/overlay
```

Finally you can update portage.
```
emerge --sync
```

# Usage
Like all overlays, there are various methods of checking what the overlay
contains. You could read through the git page, or you could go with the lazy
alternative which uses `app-portage/eix`. First make sure your eix cache is
up-to-date.
```
eix-update
```

Then to search all ebuilds contained in this overlay, you can issue the
following command:
```
eix --in-overlay setkeh-overlay
```

Packages
========

`code-insider` - Microsoft Visual Studio Code Insiders Branch For Experimental Features

`st` - A Fork of Suckless Simple Terminal by [l3pp4rd]("https://github.com/l3pp4rd") with transparency

`Keybase` - Up to date Keybase.io Client as the Current Upstream is Out of Date.