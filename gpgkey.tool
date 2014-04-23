#!/bin/bash

# Config
GpgId="${1}"
GitPath="$(git rev-parse --show-toplevel)"
: "${GpgId:="$(git config --get user.signingkey)"}"
GitUserEmail="$(git config --get user.email)"
: "${GpgId:="${GitUserEmail}"}"
LongKeyId="$(gpg --with-fingerprint --with-colons --fixed-list-mode --list-keys "${GpgId}" | grep 'fpr' | cut -f 10 -d :)"
LongKeyIdRead="$(sed -e 's:....:& :g' <<< "${LongKeyId}" | sed -e 's: $::')"
ShortKeyId="${LongKeyId: -8}"


gpg --armor --export "${LongKeyId}" > "${GitPath}/pubkey.txt"

KeyHash="$(git hash-object -w "${GitPath}/pubkey.txt")"

rm "${GitPath}/pubkey.txt"

git tag --local-user="${LongKeyId}" --file='-' "pubkeys/${ShortKeyId}" "${KeyHash}" << EOF
Key for ${GitUserEmail}

Fingerprint: ${LongKeyIdRead}
EOF

git tag -v "pubkeys/${ShortKeyId}"

exit ${?}
