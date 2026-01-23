# --- VARIÁVEIS DE AMBIENTE ---
export TERMINAL=kitty
export EDITOR=nvim

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# --- ALIASES E FUNÇÕES ---
alias grep='grep --color=auto'

# alias para o eza (substituindo o ls padrão)
alias ls='eza --icons --grid --group-directories-first'
alias ll='eza --icons --long --group-directories-first --git'

# alias para o bat (substituindo o cat padrão)
alias cat='bat --style=plain --paging=never'

# Sempre que limpar, recria o fastfetch
clear() {
    command clear

    # Só inicia o fastfetch se NÃO estiver no terminal do Code OSS ou Zed
    if [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "zed" ]; then
        fastfetch
    fi
}

# --- INICIALIZAÇÃO ---

# Só inicia o fastfetch se NÃO estiver no terminal do Code OSS ou Zed
if [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "zed" ]; then
    fastfetch
fi

# Só inicia o starship se NÃO for um TTY
if [ "$TERM" != "linux" ]; then
    eval "$(starship init zsh)"
else
    # Prompt simples para o TTY (evita o archlinux%)
    export PROMPT='%F{blue}%n%f@%F{green}%m%f:%F{cyan}%~%f$ '
fi