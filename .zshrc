# --- VARIÁVEIS DE AMBIENTE ---
export MOZ_ENABLE_WAYLAND=1
export TERMINAL=kitty
export EDITOR=nvim

# --- ALIASES E FUNÇÕES ---
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Sempre que limpar, recria o fastfetch
clear() {
    command clear
    fastfetch
}

# --- INICIALIZAÇÃO ---

# Inicia o Fastfetch assim que abre o terminal
fastfetch

# Inicia o Starship
eval "$(starship init zsh)"
