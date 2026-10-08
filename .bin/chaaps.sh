#!/usr/bin/env bash
#
# Pick one of the chaaps project directories from a menu and open it in nvim,
# started inside that directory. The menu itself is ~/.bin/bashrc.sh, which
# takes the entries to offer as arguments.
#
# No exec and no exit here, so this stays harmless if it is ever sourced.

MENU_TITLE='Select a chaaps project' ~/.bin/bashrc.sh \
  ~/Projects/chaaps/chaaps-v1/ \
  ~/Projects/chaaps/chaaps-v1/chaaps-v1-installer \
  ~/Projects/chaaps/chaaps-v2/ \
  ~/Projects/chaaps/chaaps-v2/chaaps-v2-installer \
  ~/Projects/chaaps/msc-cloud/
