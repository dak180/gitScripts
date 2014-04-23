#!/bin/bash

# Config
CurrentBranch="$(git symbolic-ref -q --short HEAD)"
LocalBranchList="$(git for-each-ref --format='%(refname:short)' refs/heads/ 2>/dev/null)"

# Update the branches that are not checked out
for WorkingBranch in ${LocalBranchList}; do
	TrackingBranch="$(git for-each-ref --format='%(upstream:short)' "refs/heads/${WorkingBranch}" 2>/dev/null)"
	if [[ ! "${WorkingBranch}" = "${CurrentBranch}" ]] && [[ ! -z "${TrackingBranch}" ]]; then
		git branch -f "${WorkingBranch}" "${TrackingBranch}"
	fi
done

# Update the currently checked out branch
TrackingBranch="$(git for-each-ref --format='%(upstream:short)' "refs/heads/${CurrentBranch}" 2>/dev/null)"
if [[ ! -z "${CurrentBranch}" ]] && [[ ! -z "${TrackingBranch}" ]]; then
	git reset --hard "${TrackingBranch}"
fi

exit 0
