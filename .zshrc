# lsd, oh-my-zsh, starship, mtodo
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/home/mvayk/.spicetify
export PATH="$HOME/.cargo/bin:$PATH"

plugins=(
  git
  sudo
  extract
  colored-man-pages
  copypath
  fzf
  zoxide
  you-should-use
  fzf-tab
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias clear="clear && mtodo list"
alias cat="bat --paging=never"
alias ls="lsd -l"
alias ll="lsd"
alias la="lsd -la"
alias lt="lsd --tree --depth 2"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_ALT_C_OPTS="--preview 'lsd --tree --depth 2 --color=always {}'"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

function y() {
    local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
    yazi "$@" --cwd-file="$tmp"
    cwd="$(<"$tmp")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

setopt AUTO_CD
setopt CORRECT
mkcd() { mkdir -p "$1" && cd "$1" }

# bindkey '^H' backward-char
# bindkey '^L' forward-char
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export FZF_DEFAULT_OPTS="--bind ctrl-j:down,ctrl-k:up,ctrl-h:backward-char,ctrl-l:forward-char"

zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down' 'ctrl-k:up'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
zstyle ':completion:*' menu no

HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY

_accept_suggestion_or_complete() {
    if [[ -n $POSTDISPLAY ]]; then
        zle forward-char
    else
        zle fzf-tab-complete
    fi
}
zle -N _accept_suggestion_or_complete

bindkey '^I' _accept_suggestion_or_complete

eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(pay-respects zsh --alias)"

mtodo list
