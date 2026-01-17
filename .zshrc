# --- VARIÁVEIS DE AMBIENTE ---
export TERMINAL=kitty
export EDITOR=nvim

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# --- ALIASES E FUNÇÕES ---
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Sempre que limpar, recria o fastfetch
clear() {
    command clear

    # Só inicia o fastfetch se NÃO estiver no terminal do Code OSS
    if [ "$TERM_PROGRAM" != "vscode" ]; then
        fastfetch
    fi
}

# --- INICIALIZAÇÃO ---

# Só inicia o fastfetch se NÃO estiver no terminal do Code OSS
if [ "$TERM_PROGRAM" != "vscode" ]; then
    fastfetch
fi

# Só inicia o starship se NÃO for um TTY
if [ "$TERM" != "linux" ]; then
    eval "$(starship init zsh)"
else
    # Prompt simples para o TTY (evita o archlinux%)
    export PROMPT='%F{blue}%n%f@%F{green}%m%f:%F{cyan}%~%f$ '
fi