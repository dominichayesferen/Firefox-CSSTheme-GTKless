# Firefox for Linux, without the GTK 'integration' (CSS modification)
...or "Firefox GTKless", is a CSS mod for Firefox that aims to get rid of as much of the GTK integration in Firefox as possible, by at least overriding it all where possible with 'lwt-theme' (the internal name for non-GTK Firefox styling) code.

![Firefox GTKless on a light theme](https://github.com/dominichayesferen/Firefox-CSSTheme-GTKless/raw/main/screenshots/light.png)

<h1>Why?</h1>

Firefox's GTK 'integration'... is a mess to put it bluntly (not to offend the people who worked on it). From issues with the titlebar buttons in Firefox REALLY not liking any GTK theme that doesn't use square titlebar buttons of a particular size, to light themed GTK controls on otherwise dark Firefox themes, to readability issues galore, Firefox has likely been the bane of a lot of GTK stylesheet developers (definitely the bane of mine, as a GTK stylesheet developer myself prior).

So, since it doesn't seem like the 'integration' is going to get better anytime soon in Firefox, I decided to take it upon myself to prove that if Firefox got rid of the GTK 'integration' it would be a less buggy experience without it... by just removing the GTK 'integration', with CSS-modding, where currently possible.

I have some limitations set, here, such as the desire to make it be usable in sandboxed versions of Firefox like the official Flatpak, so can't just recompile Firefox or whatever to do this, and this is the end result of working with those limitations in mind to try and do this.

I've decided to release the fruits of that project here, hoping that in time people can ultimately find some good use for this side-project while the 'integration' of GTK in Firefox is still the mess it is.

<h1>What does it look like?</h1>

If you've seen how Firefox looks like on Windows or macOS, then you've seen what's going on with this CSS modification. 'System Theme' under this modification has been converted into an automatically switching Light/Dark Firefox theme, switching to the style of the appropriate Firefox theme based on your current dark mode preferences, even updating on the fly (even if your GTK stylesheet is locked to light or dark).

<h2>Light Theme</h2>

![Firefox GTKless on a light theme](https://github.com/dominichayesferen/Firefox-CSSTheme-GTKless/raw/main/screenshots/light.png)

<h2>Dark Theme</h2>

![Firefox GTKless on a dark theme](https://github.com/dominichayesferen/Firefox-CSSTheme-GTKless/raw/main/screenshots/dark.png)

<h1>Installation</h1>

To install this theme, simply do the following steps:

1. See that "Releases" section on the right there? Whack the version number on it real nice.
2. Select `Source code (.zip)`.
3. Find your newly obtained .zip and extract the thing.
4. Go into the newly extracted folder.
5. From there, right-click install.sh, Properties, Permissions, Allow Executing.
6. Double-click the install.sh file.
7. Choose "Run" or "Execute".
8. Restart Firefox once done, and enjoy your new GTKless CSSTheme.

<h1>Longevity of this CSS mod?</h1>

Ultimately, I'm hoping to be done with this if Firefox ever gets decent GTK integration that rivals Chromium's, and even native GTK programs', or otherwise gets rid of that integration upstream someday. If that day ever comes (I honestly hope so), this will be archived for any future reference.

<h1>Summary of changes and known fixes they make</h1>

- Titlebar buttons have their DPI-scaling fixed, since they are now always the non-troublesome Firefox-inbuilt ones (they're normally only relegated to usage in Firefox themes, and formely in full-screen)
- Even if your GTK stylesheet is locked via an environment variable or whatever, Firefox will now still respect the dark theme preferences anyway, outside of the few hardcoded GTK controls Firefox has
- System Theme now visually matches the Light theme, on a light theme, or Dark on a dark theme, that Firefox otherwise has as optional theme selections (thus also matching how System Theme currently works on Microsoft Windows 10 and later if you don't have titlebar colouring turned on on them)
- The specific changes made to CSS when Firefox is in 'lwt-theme' mode are now applied on the "System Theme" too
- Right-click menus, and menus spawned from the optional menubar, have been overhauled to be styled after Firefox's main menu (for consistency, and because there's no official menu style otherwise)
- Buttons in Customise Toolbar are now styled after the buttons in Settings (potentially making this the first ever CSS mod to actually style the buttons in Customise Toolbar?)

<h1>Theme options in about:config</h1>

Here are options that can be set via about:config to further improve the experience while this CSS mod is installed (restart Firefox after applying them for changes to take effect):

- `gtkless.no-titlebar-spacer`: Gets rid of the functionless space on the left of the tabs in titlebars
- `gtkless.colors-adwaita`: Changes colours to be based on LibAdwaita instead

<h1>Notes</h1>

- Most of the code on the CSS is taken out of Firefox's CSS, therefore credit mainly goes to the makers of Firefox's CSS (refer to LICENSE, too)
- In the event Firefox's CSS, for the parts of it that this modification uses, changes even just slightly, the modification will still use the old CSS and therefore need to be updated
- Firefox themes are unaffected, as this CSS modification is designed to only affect "System Theme"
- Scrollbars are seemingly hardcoded so I couldn't CSS-style them
- This is in no way meant to be taken as an insult to the work done on Firefox's code, nor those maintaining Firefox
- This was tested with Adwaita as the GTK theme
