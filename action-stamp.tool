#!/bin/sh

# Config
CommitId="${1}"
: "${CommitId:=HEAD}"
TZ=UTC git show -s --date=iso-strict-local --format='%ad!%ce' "${CommitId}" | sed -e 's|+00:00|Z|' -e 's|-00:00|Z|'

exit 0
