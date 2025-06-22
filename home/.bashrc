#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ways to see long lines in fzf:
# fzf --hscroll-off 100
# fzf --wrap
# fzf --preview 'echo {} | sed -e "s/^ *\([0-9]*\) *//" -e "s/.\{$COLUMNS\}/&\n/g"' --preview-window down:2

alias _fzfpreview='fzf --preview "echo {} | sed -e \"s/^ *\\([0-9]*\\) *//\" -e \"s/.\\{$COLUMNS\\}/&\\n/g\"" --preview-window down:3'
alias _fzfdirs='find -L -type d | _fzfpreview'

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias cdf='cd "$(_fzfdirs)"'
alias vlcf='vlc "$(_fzfdirs)"'
PS1='[\u@\h \W]\$ '
