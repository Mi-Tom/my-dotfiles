# --- Pluginy (S detekcí cesty) ---
local plugins=(
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in $plugins; do
  [ -f "$plugin" ] && source "$plugin"
done

# --- Základní doplňování (Tabulátor) ---
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Umožní vybírat v menu šipkami

# --- Funkce pro Git Status  ---

setopt PROMPT_SUBST

parse_git_status() {
  # 1. Rychlá kontrola, zda jsme v Gitu
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch status_symbol=""
  
  # 2. Získání názvu větve nebo commitu (detached HEAD)
  branch=$(command git symbolic-ref --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null)

  # 3. Kontrola, zda je repozitář úplně nový (žádné commity)
  if ! command git rev-parse HEAD &>/dev/null; then
    status_symbol="#"
  else
    # 4. Kontrola Staging Area (změny připravené ke commitu)
    # diff-index vrací 1, pokud jsou rozdíly oproti HEAD
    if ! command git diff-index --quiet --cached HEAD 2>/dev/null; then
      status_symbol+="*"
    fi

    # 5. Kontrola změn v pracovním adresáři (změněné soubory + untracked)
    # diff-files pro změněné, ls-files pro úplně nové (untracked)
    if ! command git diff-files --quiet 2>/dev/null || \
       [[ -n "$(command git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
      status_symbol="+"
    fi
  fi

  # 6. Výstup: celé žluté v závorkách
  echo " %F{yellow}($branch$status_symbol)%f"
}

PROMPT='%F{white}%D{%H:%M}%f %B%F{green}%n@%m%f%b %F{cyan}%~%f$(parse_git_status)
%F{white}$%f '

alias update="sudo pacman -Syu"
alias newhome="home-manager switch --flake"

alias ls="ls --color=auto"
alias ll="ls -lah --color=auto"
alias grep="grep --color=auto"
alias ..="cd .."

alias gti="git"

# --- Nastavení Historie ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY          # Sdílení historie mezi terminály
setopt APPEND_HISTORY         # Přidávání do historie místo přepisování
setopt HIST_IGNORE_ALL_DUPS   # Ignorovat duplicitní příkazy

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

eval "$(direnv hook zsh)"
fastfetch
