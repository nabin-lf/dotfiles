# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Aliases
alias dev="bun run dev"
alias start="bun run start"
alias build="bun run build"
alias install="bun i"

# Postgres
# alias pgc='pgcli "postgresql://postgres:password@localhost:5435/postgres"'
# alias pg='pgcli "postgres://postgres:password@localhost:5435/solar"'

# SSH
# alias humanfitServer="ssh human@103.94.159.236 -p 2035"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Git aliases
alias gs="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias gt="git"
alias ga="git add ."
alias glog="git log --all --graph --pretty=format:'%C(yellow)%h%Creset - %C(cyan)%cd%Creset %Cgreen(%an)%Creset %s' --date=short"

# eza aliases
alias ls='eza --color=always --group-directories-first'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git --time-style=relative'
alias lsize='eza -l --sort=size --icons'
alias lmod='eza -l --sort=modified --icons'
alias ldot='eza -la --icons --git --sort=modified --time-style=relative'
alias efz='eza -1 | fzf'
alias ldirs='eza -T -D -L 2'
alias ltree='eza -T -L 2 -l --icons --git'

# bat alias
alias cat='bat'

# fzf config
export FZF_DEFAULT_OPTS="--bind='j:down,k:up,h:toggle-preview,l:toggle+down'"

# fzf shell integration (Ctrl+R = history, Ctrl+T = files, Alt+C = cd)
source <(fzf --zsh 2>/dev/null) 2>/dev/null || {
    # Fallback if fzf --zsh not available
    bindkey '^R' fzf-history-widget
    bindkey '^T' fzf-file-widget
    bindkey '^[c' fzf-cd-widget
}

# nvim fuzzy finder
alias v='fd --type f --hidden --exclude .git --exclude node_modules | fzf-tmux -p --reverse | xargs nvim'
alias vi='fd --type f --hidden --exclude .git --exclude node_modules \
  | fzf-tmux -p --reverse \
  --preview "bat --style=numbers --color=always {} || cat {}" \
  | xargs nvim'

# Project navigator
alias projnav='cd $(fd -t d . ~/documents | fzf) && tmux && nvim .'

# Keybindings
bindkey -e
bindkey '^[w' kill-region
bindkey '^P' autosuggest-accept

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Utility aliases
alias vim='nvim'
alias c='clear'

# starship
eval "$(starship init zsh)"
# zoxide
eval "$(zoxide init --cmd cd zsh)"

# opencode
export PATH=/home/leapfrog/.opencode/bin:$PATH
