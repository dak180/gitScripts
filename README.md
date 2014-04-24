# gitScripts


Custom git sub-commands.

## gitx.tool

A simple redirection to gitx for use as a git sub-command.

## gpgkey.tool

A tool to add the current (or specified) identity's public `gpg` key to a git repository as a self signed tag.

## gpgkey-import.tool

Import gpg keys stored in a repository as tags that take the form of `refs/tags/pubkeys/*` or `refs/tags/pubkey`.

## mpush.tool

Push to multiple repositories at once; uses `remotes.main` and `remotes.me` to list push locations

## update.tool

Do the equivalent of `git reset --hard <upstream tracking branch>` for all branches (checked out or not) that have an upstream tracking branch.
