#!/bin/bash
#
# Description: node/npm Configuration
#

# Node Runtime Version Managers
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi
