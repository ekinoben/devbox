# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# Git shell integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{130}(%b)%r%f'
zstyle ':vcs_info:*' enable git

PROMPT='%B%F{25}%3~%f%b %# '


# NVM config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Activate Autojump
. /usr/share/autojump/autojump.zsh

# sudo aliases
alias sudo='sudo '

# ls shortcuts
alias ls="command ls -G"
alias l="ls -lFG" # all files, in long format
alias la="ls -laFG" # all files inc dotfiles, in long format

# quick nav
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# git aliases
alias gs='git status -sb'
alias gl='git log --oneline --decorate'
alias glv='git log --pretty=format:"%C(yellow)%h %C(blue)%ad%C(red)%d %C(reset)%s%C(green) [%cn]" --decorate --date=short --numstat'
alias gco='git checkout'
alias ga='git add .'
alias gp='git push origin HEAD'
alias gitrecent='git for-each-ref --count=5 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
alias gitfresh='git fetch --all && git checkout master && git pull origin master'
gc() {
    if [ -n "$1" ]
    then
        git commit -m "$1"
    else
        git commit --amend --no-edit
    fi
}
