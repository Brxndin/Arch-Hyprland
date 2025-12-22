#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Definição do terminal padrão
export TERMINAL=kitty
fastfetch

# sobescreve a função clear para fazer o fastfetch junto
clear() {
    command clear
    fastfetch
}
