#!/bin/bash

SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# Firefox GTKless installation script, from https://github.com/dominichayesferen/Firefox-CSSTheme-GTKless
# This script is Public Domain, unlike the rest of the project which is licensed under MPL-2.0, so here's P.D. licensing:

# This is free and unencumbered software released into the public domain.

# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org>


success=0
for directory in ~/.mozilla/firefox ~/snap/firefox/common/.mozilla/firefox ~/.var/app/org.mozilla.firefox/.mozilla/firefox ~/.librewolf ~/.var/app/io.gitlab.librewolf-community/.librewolf ~/.floorp ~/.var/app/one.ablaze.floorp/.floorp ~/.waterfox ~/.var/app/net.waterfox.waterfox/.waterfox ~/.var/app/net.mullvad.MullvadBrowser/.mullvad; do
    if [ -d $directory ]; then
        cd $directory
        if [ "$success" -gt 0 ]; then echo ""; fi
        for profile in *; do if [ -f "$profile/prefs.js" ]; then
            echo "Detected profile: $directory/$profile, installing Firefox GTKless to this profile..."
            if [ -d "$profile/chrome" ]; then
                if ! grep -q '/* FIREFOX GTKLESS STYLE CHECK HEADER -' "$profile/chrome/GTKless.css" && ! grep -q '/* FIREFOX GTKLESS STYLE CHECK HEADER -' "$profile/chrome/ferenChrome.css"; then
                    bkupcounts=0
                    while [ -d "$profile/chrome.bak""$bkupcounts" ]; do
                        bkupcounts=$(($bkupcounts+1))
                    done
                    mv -f "$profile/chrome" "$profile/chrome.bak""$bkupcounts"
                    echo "Backed up your old userChrome folder to chrome.bak""$bkupcounts."
                else #Delete old GTKless, but leave userChrome.css intact, if it's just an installation of GTKless
                    if [ -f "$profile/chrome/ferenChrome.css" ]; then
                        rm -f "$profile/chrome/ferenChrome.css"
                    fi
                    rm -f "$profile/chrome/GTKless.css"
                fi
            fi
            if [ ! -d "$profile/chrome" ]; then #On new installs, remake the chrome folder...
                mkdir "$profile/chrome"
            fi
            if [ ! -f "$profile/chrome/userChrome.css" ]; then #...and copy everything over.
                cp -Rf "$DIR/mod-files/chrome/"* "$profile/chrome/"
            else #If GTKless is already installed, only replace GTKless's CSS
                if grep -q 'ferenChrome.css' "$profile/chrome/userChrome.css"; then
                    sed -i 's/ferenChrome.css/GTKless.css/g' "$profile/chrome/userChrome.css"
                fi
                if grep -q 'ferenChrome.css' "$profile/chrome/userContent.css"; then
                    sed -i 's/ferenChrome.css/GTKless.css/g' "$profile/chrome/userContent.css"
                fi
                cp -f "$DIR/mod-files/chrome/GTKless.css" "$profile/chrome/"
            fi
            #Now it's user.js's turn
            if [ -f "$profile/user.js" ]; then
                if ! grep -q '// Mozilla User Preferences for GTKless' "$profile/user.js"; then
                    bkupcounts=0
                    while [ -f "$profile/user.js""$bkupcounts" ]; do
                        bkupcounts=$(($bkupcounts+1))
                    done
                    mv -f "$profile/user.js" "$profile/user.js""$bkupcounts"
                    echo "Backed up your old user.js file to user.js""$bkupcounts."
                else #Delete old user.js if it's just an installation of GTKless too
                    rm -rf "$profile/user.js"
                fi
            else
                rm -f "$profile/user.js" #In case there's a dangling symlink
            fi
            cp -f "$DIR/mod-files/user.js" "$profile/"
            success=$(($success+1))
        fi; done
    fi
done

cd
if [ "$success" -gt 0 ]; then
    echo "
Installation complete. Restart Firefox for the changes to take effect."
fi
