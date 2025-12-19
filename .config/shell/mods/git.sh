#!/bin/sh

#---- Aliases ------------------------------------------------------------------
alias \
	ga='git add'                           \
	gc='git commit'                        \
	gco='git checkout'                     \
	gd='git diff'                          \
	gl='git log --oneline --color=always'  \
	gs='git status'                        \
	gsu='git status --untracked-files=all' \
	gwl='git worktree list'                \
	gwr='git worktree remove'              \
 
#---- Functions ----------------------------------------------------------------

# Adds a new Git worktree for a specified branch.
# 
# @param The name of the branch to add as a worktree.
#
# @usage wta <BRANCH_NAME>
#
# @example gwa feature/my-new-feature
gwa() {
	branch="$1"
	[ -z "$branch" ] && {
		echo "Usage:	$0 <BRANCH>" 1>&2
		return 1
	}
	gitroot=$(git rev-parse --show-toplevel)
	echo "Fetching Remote Branch: $branch ..."
	git fetch origin "$branch" >/dev/null 2>&1
	git worktree add "$gitroot/../$branch" "$branch"

}
