setopt prompt_subst
autoload -Uz compinit colors vcs_info

# Completion
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
setopt completealiases

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

#History
setopt HIST_IGNORE_DUPS

HISTFILE=${HISTFILE:-${ZDOTDIR:-${HOME}}/.zsh_history}
HISTSIZE=5000
SAVEHIST=10000

bindkey "^[[5~" history-beginning-search-backward # PgUp
bindkey "^[[6~" history-beginning-search-forward  # PgDown

#Antifreeze
ttyctl -f

#Colors & hightlighting
colors

if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias irclog="grc --colour=auto irclog"
 alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias proftpd="grc --colour=auto proftpd"
 alias traceroute="grc --colour=auto traceroute"
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#Git
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' actionformats "%F{green}[%b]%f %F{yellow}%r/%S%f %F{red}(%a) %m%u%c%f"
zstyle ':vcs_info:git*' formats "%F{green}[%b]%f %F{yellow}%r/%S%f %F{red}%m%u%c%f"

precmd() { vcs_info }

#Prompt
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
  p0="%F{cyan}%n@%m%f"
fi

if [[ $EUID == 0 ]]; then
  p1="%F{red}%#%f "
else
  p1="%F{green}%#%f "
fi

rp="%F{yellow}%~%f"

check_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ LAST_EXIT_CODE -ne 0 ]]; then
    echo "%F{red}$LAST_EXIT_CODE%f"
  fi
}

PROMPT="${p0}${p1}"
RPROMPT='$(check_exit_code)${vcs_info_msg_0_:-$rp}'

#Aliases
alias ls='ls -F --color=auto'
alias la='ls -A'
alias ll='ls -l -h'
alias lla='ll -A'

alias cp='cp -r'
alias scp='scp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'

alias grep='grep --color=auto'
