#!/bin/sh

# Config
CommitId="${1}"
: "${CommitId:=HEAD}"
CommitTime="$(git log -1 --pretty=format:%ct "${CommitId}" --)"
CommitTimeStamp="$(perl -MPOSIX=strftime -e 'print strftime("%FT%TZ", gmtime($ARGV[0])), "\n"'  "${CommitTime}")"
CommitEmail="$(git log -1 --pretty=format:%cE "${CommitId}" --)"

echo "${CommitTimeStamp}!${CommitEmail}"

exit 0
