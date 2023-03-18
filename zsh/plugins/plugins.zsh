# Environment variables
# ----------------------------------------

export ZINIT_HOME=$ZDOTDIR/zinit

# Configuration
# ........................................

if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  echo "Installing zdharma-continuum/zinit."
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source $ZDOTDIR/zinit/zinit.zsh

# Load plugins
# ........................................

# zinit ice depth=1 
# zinit light jeffreytse/zsh-vi-mode

zinit load zsh-users/zsh-syntax-highlighting

# zinit wait lucid for \
#       zdharma-continuum/fast-syntax-highlighting 

zinit ice wait lucid atload="zicompinit; zicdreplay" blockf 
zinit load zsh-users/zsh-completions

zinit ice wait lucid 
zinit load lincheney/fzf-tab-completion

zinit ice wait lucid atload="!_zsh_autosuggest_start" 
zinit load zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit load zsh-users/zsh-history-substring-search 

zinit ice wait lucid
zinit load hlissner/zsh-autopair 

# zinit ice wait lucid 
# zinit load Aloxaf/fzf-tab

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Configure plugins
# ----------------------------------------

for conf in $ZPLUGINDIR/*/conf.zsh; do

  source "$conf"

done

