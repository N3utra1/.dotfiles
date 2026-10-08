#!/bin/sh
#
# Load X resources: the shared ~/.config/X11/Xresources first, then
# ~/.config/X11/<hostname>.Xresources so a machine can override font size, DPI
# or colours for its own display. Either file may be absent.
#
# Run from the i3 config on startup and reload. ~/.Xresources is not used, so
# the Xsession scripts that load it automatically find nothing.

command -v xrdb >/dev/null 2>&1 || exit 0

for file in "$HOME/.config/X11/Xresources" \
            "$HOME/.config/X11/$(hostname -s).Xresources"; do
  [ -r "$file" ] && xrdb -merge "$file"
done
exit 0
