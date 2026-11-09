# lsd, oh-my-zsh, starship, mtodo
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/home/mvayk/.spicetify

plugins=(
  git
  sudo
  extract
  colored-man-pages
  copypath
  history-substring-search
  fzf
  zoxide
  you-should-use
  fzf-tab
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias clear="clear && mtodo list"
alias cat="bat --paging=never"
alias ls="lsd -l"
alias ll="lsd"
alias la="lsd -la"
alias lt="lsd --tree --depth 2"

bindkey '^H' backward-char
bindkey '^L' forward-char
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
mtodo list
