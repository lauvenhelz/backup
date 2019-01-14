#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source /usr/bin/virtualenvwrapper.sh
source /usr/share/git/completion/git-completion.bash
source /usr/share/stgit/completion/stgit-completion.bash
source /usr/share/git/completion/git-prompt.sh

function __prompt_stgit()
{
	local git_dir ref br top;
	git_dir=$(git rev-parse --git-dir 2> /dev/null) || return
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	br=${ref#refs/heads/}
	top=$(tail -n 1 $git_dir/patches/$br/applied 2>/dev/null)
	[ -z "$top" ] || echo -n "($top)"
}

PS1='\[\033[01;34m\]\w\[\033[31m\]$(__git_ps1 "[%s]")\[\033[01;32m\]$(__prompt_stgit)\[\033[01;34m\]$\[\033[00m\] '

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
source /usr/share/git/completion/git-prompt.sh

export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoredups
export HISTFILESIZE=5000
export HISTSIZE=5000
export EDITOR=vim
shopt -s histappend

__fab_tasks() {
    local prev cur
    _get_comp_words_by_ref cur prev
    COMPREPLY=( $( compgen -W "`fab -l -F short`" -- "$cur" ) )
    return 0
} &&
complete -F __fab_tasks fab
