# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Enable plugins.
plugins=(git brew history docker docker-compose podman)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/gitstatus/gitstatus.prompt.zsh

# Vim gruvbox color palette
# source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# Allow history search via up/down keys.
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Nicer prompt.
PROMPT="%F{green}# %3~ %F{white}"$'\n'"$ "
RPROMPT='$GITSTATUS_PROMPT'

# Completions.
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# User configuration
eval "$(/opt/homebrew/bin/brew shellenv)"
export EDITOR='vim'
export GOPATH=$HOME/.go
export TERM=screen-256color
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/local/git/bin:$PATH
export LANG=en_US.UTF-8

# History file configuration
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=500000

# History command configuration
setopt extended_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Git bare setup for my config.
alias dotfiles='/usr/bin/git --git-dir=/Users/jasyuiop/.cfg/ --work-tree=/Users/jasyuiop'

# Create tmux sessions
alias mux='tmux new-session -D -s "My Session"'
alias work='tmux new-session -D -s "Work"'

# Useful alias
alias df='df -h'
alias du='du -sh'
alias chmox='chmod +x'
alias diff='diff --color'
alias more='less'
alias ll='ls -l'
alias rm='rm -I'
alias vi='vim'

# Git alias
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Python alias
alias python='python3.11'
alias pip='pip3.11'
alias activate='chmod +x ./.venv/bin/activate && source ./.venv/bin/activate'
alias venv='python -m venv .venv'

# Brew alias
alias bubu='brew update && brew outdated && brew upgrade && brew cleanup'

# Aria2
alias aria='aria2c --conf-path=$HOME/.aria2/aria2.conf'

# Podman
alias podu='podman machine start'
alias podd='podman machine stop'
alias podi='podman machine info'

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
