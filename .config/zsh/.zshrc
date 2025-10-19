# Prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# General options
setopt auto_cd
setopt no_nomatch

# History in cache directory:
[[ -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ]] || mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Completion
autoload -U compinit
zmodload zsh/complist
ZCOMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump
compinit -C -d "$ZCOMPDUMP"
_comp_options+=(globdots)
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

# case insensitive (all), partial-word and substring completion
: ${CASE_SENSITIVE:=false}
: ${HYPHEN_INSENSITIVE:=false}
if [[ "$CASE_SENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
    local _hpat='m:{a-zA-Z}={A-Za-z}'
    [[ "$HYPHEN_INSENSITIVE" = true ]] && _hpat='m:{a-zA-Z-_}={A-Za-z_-}'
    zstyle ':completion:*' matcher-list "$_hpat" 'r:|=*' 'l:|=* r:|=*'
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# vi mode
bindkey -v
export KEYTIMEOUT=5

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Some bindkeys (ensure they apply in vi insert mode)
bindkey -M viins '^p' up-line-or-history
bindkey -M viins '^n' down-line-or-history
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^o' autosuggest-accept

# Load plugins
eval "$(zoxide init zsh)"
[[ -r "$ZDOTDIR/plugins/F-Sy-H/F-Sy-H.plugin.zsh" ]] && source "$ZDOTDIR/plugins/F-Sy-H/F-Sy-H.plugin.zsh" 2>/dev/null
[[ -r "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null

# Alias
alias history='fc -l 1'
alias ls='exa'
alias l='exa -lah'
alias tree='exa -Tlah'
alias vi='nvim'
alias svi='sudoedit'
alias df='df -Th'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
