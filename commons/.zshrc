local plugins=(
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

[ -f "$HOME/.zsh_functions" ] && source "$HOME/.zsh_functions"
[ -f "$HOME/.zsh_local" ] && source "$HOME/.zsh_local"

for plugin in $plugins; do
    [ -f "$plugin" ] && source "$plugin"
done

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# --- Function for Git Status  ---

setopt PROMPT_SUBST

parse_git_status() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch status_symbol=""
  
    branch=$(command git symbolic-ref --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null)

    if ! command git rev-parse HEAD &>/dev/null; then
        status_symbol="#"
    else
        if ! command git diff-index --quiet --cached HEAD 2>/dev/null; then
            status_symbol+="*"
        fi

        if ! command git diff-files --quiet 2>/dev/null || [[ -n "$(command git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
            status_symbol="+"
        fi
    fi

    echo " %F{yellow}($branch$status_symbol)%f"
}

# --- Prompt mód: horizontal (poslední 2 adresáře) / vertical (celá cesta) ---
# Přepínání: pm h / pm v   nebo   prompt-mode horizontal / prompt-mode vertical
PROMPT_MODE="horizontal"

_prompt_path() {
    if [[ "$PROMPT_MODE" == "vertical" ]]; then
        echo "%~"
    else
        local full="${PWD/#$HOME/~}"
        local parts=("${(@s:/:)full}")
        if (( ${#parts[@]} <= 2 )); then
            echo "$full"
        else
            echo "…/${parts[-2]}/${parts[-1]}"
        fi
    fi
}

prompt-mode() {
    case "$1" in
        horizontal|h) PROMPT_MODE="horizontal" ;;
        vertical|v)   PROMPT_MODE="vertical"   ;;
        *)
            echo "Usage: pm [h|v]  or  prompt-mode [horizontal|vertical]"
            return 1
            ;;
    esac
    echo "Prompt mode: $PROMPT_MODE"
}


PROMPT='%F{white}%D{%H:%M}%f %B%F{green}%n@%m%f%b %F{cyan}$(_prompt_path)%f$(parse_git_status)
%F{white}€%f '

export EDITOR=nvim

bindkey -s '^Xpm' 'sudo pacman -S'
bindkey -s '^Xgc' 'git commit -m ""\C-b'

alias la="ls -A"
alias ls="ls --group-directories-first --color=auto"
alias grep="grep --color=auto"

alias ..="cd .."
alias ...="cd ../.. && ls -d */ && echo "" && ls -d .*/"
alias ~="cd ~"
alias dot="cd ~/.config/my-dotfiles"

alias vim="nvim"

alias gti="git"

alias pm="prompt-mode"

# --- Histori settings ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

fastfetch

# Created by `pipx` on 2026-04-14 09:07:09
export PATH="$PATH:/home/michal/.local/bin"