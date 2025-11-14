## Documentation:
##   qute://help/configuring.html
##   qute://help/settings.html
## This is here so configs done via the GUI are still loaded.
## Remove it to not load settings done via the GUI.
config.load_autoconfig(True)

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
c.aliases = {
    'w': 'session-save',
    'rc': 'config-source',
    'q': 'close',
    'qa': 'quit',
    'wq': 'quit --save',
    'wqa': 'quit --save'
}

## Require a confirmation before quitting the application.
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
c.confirm_quit = ['downloads']

## Automatically start playing `<video>` elements.
## Type: Bool
c.content.autoplay = False

## Which cookies to accept.
## Valid values:
##   - all: Accept all cookies.
##   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
##   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
##   - never: Don't accept cookies at all.
c.content.cookies.accept = 'no-3rdparty'

## Allow websites to share screen content.
## Valid values:
##   - true
##   - false
##   - ask
c.content.desktop_capture = False

## Try to pre-fetch DNS entries to speed up browsing.
c.content.dns_prefetch = False

## Allow websites to request geolocations.
## Valid values:
##   - true
##   - false
##   - ask
c.content.geolocation = False

## Allow websites to record audio.
## Valid values:
##   - true
##   - false
##   - ask
c.content.media.audio_capture = False

## Allow websites to record audio and video.
## Valid values:
##   - true
##   - false
##   - ask
c.content.media.audio_video_capture = False

## Allow websites to record video.
## Valid values:
##   - true
##   - false
##   - ask
c.content.media.video_capture = False


## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

## Search engines which can be used via the address bar.  Maps a search
## engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
## placeholder. The placeholder will be replaced by the search term, use
## `{{` and `}}` for literal `{`/`}` braces.  The following further
## placeholds are defined to configure how special characters in the
## search terms are replaced by safe characters (called 'quoting'):  *
## `{}` and `{semiquoted}` quote everything except slashes; this is the
## most   sensible choice for almost all search engines (for the search
## term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
## * `{quoted}` quotes all characters (for `slash/and&amp` this
## placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
## nothing (for `slash/and&amp` this placeholder   expands to
## `slash/and&amp`). * `{0}` means the same as `{}`, but can be used
## multiple times.  The search engine named `DEFAULT` is used when
## `url.auto_search` is turned on and something else than a URL was
## entered to be opened. Other search engines can be used by prepending
## the search engine name to the search term, e.g. `:open google
## qutebrowser`.
## Type: Dict
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q=g!+{}',
    'yt': 'https://www.youtube.com/results?search_query={}',
}


## ================ CUSTOM =====================
# NOTE: colors-<mode>.py (dark|light) should symlink to a dark/light mode, respectively, to make it
# easy to switch light/dark themes by just sourcing the appropriate one.
config.source("themes/colors-dark.py")

# custom binding to open mpv for current url (assuming its a url that can be handled by ytdl)
config.bind(",v", "hint links spawn mpv --profile=ytv --wayland-app-id=ytv {hint-url}")

# toggle between left and top tabs
config.bind(",t", "config-cycle tabs.position top left")

# "minimize" vertical tab width
config.bind(",m", "config-cycle tabs.width 18% 3%")

# toggle status bar viz
config.bind(",ss", "config-cycle statusbar.show always never")
# toggle tabs viz
config.bind(",st", "config-cycle tabs.show always never")

