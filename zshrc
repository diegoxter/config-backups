# Created by diegoxter for 4.3.11

#setopt NOTIFY
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt auto_cd
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile 

MPD_HOST=192.168.1.250
MPD_PORT=6600
XDG_CONFIG_HOME='/home/diegoxter/.config/'
PATH="/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/sbin:/usr/sbin:$PATH"
TZ="America/Caracas"
HISTFILE=$XDG_CONFIG_HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
BROWSER='chromium'
#Prompt
autoload -U colors && colors
PS1="%{$fg[red]%}[%n]%{$reset_color%} @ %{$fg[blue]%}[%m] %{$reset_color%}en %{$fg[green]%}[%~] %{$reset_color%}"


LC_ALL='es_ES.UTF-8'
LANG='es_ES.UTF-8'
LC_CTYPE=C

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------

#alias clyde='sudo clyde'
alias ungz='tar -xvf'
alias unbz='tar -xvj'
alias mpc='mpc -h 127.0.0.1 -p 6600'
alias pacrem='sudo pacman -Rns'
alias pacsea='packer -Ss'
alias pacins='packer -S'
alias pacupd='packer -Syu '
alias nc='ncmpcpp'
alias hp="hp-toolbox"
alias ll='ls -al'
alias ls='ls --color=auto '

#Clyde Settings
clyde() {
   case $1 in
       -S | -S[^sih]* | -R* | -U*)
           /usr/bin/sudo /usr/bin/clyde "$@" ;;
       *)
           /usr/bin/clyde "$@" ;;
   esac
}

#chpwd

autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 

export CDPATH="$HOME/Descargas/:$HOME/Dropbox/:$HOME/builds/"
export LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so
