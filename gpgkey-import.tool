#!/bin/sh

# Config
GitPath="$(git rev-parse --show-toplevel)"
PubKeysList="$(git for-each-ref --format="%(refname)" refs/tags/pubkeys/* refs/tags/pubkey)"

cd "${GitPath}"

for PubKey in ${PubKeysList}; do
	TagName="${PubKey#refs/tags/}"
	git cat-file blob "${TagName}" | gpg  --armor --import
done

exit 0
