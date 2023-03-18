# zmodload zsh/zprof

export ZCOREDIR=$ZDOTDIR/core
export ZTHEMEDIR=$ZDOTDIR/theme
export ZPLUGINDIR=$ZDOTDIR/plugins

fpath+=$ZDOTDIR/autoloads
autoload -Uz $ZDOTDIR/autoloads/*

if uname | grep -q Darwin &> /dev/null; then
  PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

source "$ZCOREDIR/core.zsh"
source "$ZTHEMEDIR/theme.zsh"
source "$ZPLUGINDIR/plugins.zsh"

# zprof 
