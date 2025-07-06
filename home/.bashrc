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
# alias _fzfdirs='find -L -type d | _fzfpreview'

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias cdf='cd "$(dirname "$(_fzfpreview)")"'
# alias vlcf='vlc "$(_fzfdirs)"'

#COLOR0='\[\e[00m\]'
#COLOR1='\[\e[01;34m\]'
#COLOR2='\[\e[01;32m\]'
#COLOR3='\[\e[01;36m\]'

#PS1='[\u@\h \W]\$ '
#PS1="$COLOR1\u$COLOR0:$COLOR2\W$COLOR0 > "
PS1="\u:\W > "
