local plugins=(
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

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

    if ! command git diff-files --quiet 2>/dev/null || \
       [[ -n "$(command git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
      status_symbol="+"
    fi
  fi

  echo " %F{yellow}($branch$status_symbol)%f"
}

PROMPT='%F{white}%D{%H:%M}%f %B%F{green}%n@%m%f%b %F{cyan}%~%f$(parse_git_status)
%F{white}$%f '


alias lsa="ls -A"
alias ls="ls --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias ..="cd .."

alias gti="git"

# --- Histori settings ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

fastfetch
