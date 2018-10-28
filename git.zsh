function git_dirty() {
    n_added=$(expr `git status --porcelain 2>/dev/null| grep "^M" | wc -l`)
    n_modified=$(expr `git status --porcelain 2>/dev/null| grep "^ M" | wc -l`)
    n_untracked=$(expr `git status --porcelain 2>/dev/null| grep "^??" | wc -l`)
    if [[ "$(($n_added + $n_untracked + $n_modified))" == '0' ]]; then
	print -P "%F{green}✓%f"
    else
	print "%F{red}✗%f"
    fi
}

function is_git() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
	branch=$(git rev-parse --abbrev-ref HEAD)
	print "%F{yellow}( ${branch} )%f $(git_dirty) "
    else
	print ''
    fi
}
