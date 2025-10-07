set fish_greeting ""
fzf_key_bindings
starship init fish | source

function fzf-open
    set -l selection (find ~ -type f -o -type d 2>/dev/null | fzf --preview 'if [ -d {} ]; then tree -C {} | head -50; else bat --style=numbers --color=always {} 2>/dev/null || cat {}; fi')
    if test -n "$selection"
        if test -f "$selection"
            # Get MIME type
            set -l mime_type (file --mime-type -b "$selection")
            if string match -q 'image/*' -- "$mime_type"
                feh "$selection"
            else if string match -q 'video/*' -- "$mime_type"
                mpv "$selection"
            else
                nvim "$selection"
            end
        else if test -d "$selection"
            cd "$selection"
        end
    end
end

alias ls="eza -l --icons"
alias clear="clear && pfetch"
alias emacs="emacsclient -c -a 'emacs'"
alias vim="nvim"

bind \cf fzf-open

if status is-interactive
    # Commands to run in interactive sessions can go here
end
