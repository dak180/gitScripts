#!/bin/sh

# Config
RemotesMain="$(git config --get remotes.main 2>/dev/null)"
RemotesMe="$(git config --get remotes.me 2>/dev/null)"
OriginFallBack="$(git config --get remote.origin.pushurl 2>/dev/null)"

cd "$(git rev-parse --show-toplevel 2>/dev/null)"

if [ -z "${RemotesMain}" ] && [ -z "${RemotesMe}" ] && [ -z "${OriginFallBack}" ]; then
	echo "Nowhere to push to"
	exit 1
elif [ -z "${RemotesMain}" ] && [ -z "${RemotesMe}" ]; then
	git push origin
	exit ${?}
elif [ -z "${RemotesMain}" ]; then
	PushList="${RemotesMe}"
else
	PushList="${RemotesMain} ${RemotesMe}"
fi


for PushRemote in ${PushList}; do
	if ! git push "${PushRemote}"; then
		echo "warning: push to ${PushRemote} failed"
		git fetch --multiple -p "${PushRemote}"
		exit 1
	fi
done

exit 0
