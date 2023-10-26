export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_DIR="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

export BASH_ENV="$HOME/.bashrc"

export MAILDIR="$HOME/.mail"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export SUDO_EDITOR="nvim"
export EDITOR="nvim"

# if uname | grep -q Darwin &> /dev/null; then
#   alias alacritty="alacritty --config-file=$XDG_CONFIG_HOME/alacritty/alacritty_macOS.yml"
# else
#   alias alacritty="alacritty --config-file=$XDG_CONFIG_HOME/alacritty/alacritty_arch.yml"
# fi
#
scripts=('tmux' 'neomutt' 'davmail' 'khal' 'vdirsyncer' 'statnot' 'hypr')

for i in "${scripts[@]}"; do
  [[ -d $XDG_CONFIG_HOME/$i/scripts ]] && path=("$XDG_CONFIG_HOME/$i/scripts" "${path[@]}")
done

path+=$HOME/.cargo/bin

export BROWSER='brave'


typeset -U path
path+=$HOME/.local/bin

if uname | grep -q Darwin &> /dev/null; then
  PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  path+=("/Library/Tex/texbin")
fi

fpath+=$ZDOTDIR/autoloads
autoload -Uz $ZDOTDIR/autoloads/*
