typeset -U path
path+=$HOME/.local/bin

export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_DIR="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export BASH_ENV="$HOME/.bashrc"

export MAILDIR="$HOME/.mail"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export DOTDIR="$HOME/Dropbox/dots/minimal"

export SUDO_EDITOR="nvr -s"
export EDITOR="nvr -s"

if uname | grep -q Linux &> /dev/null; then
  export SUDO_ASKPASS="$HOME/.local/bin/dmenu_sudo_askpass"
fi

if uname | grep -q Darwin &> /dev/null; then
  path+=("/opt/homebrew/bin" "/opt/homebrew/sbin")
fi

if uname | grep -q Darwin &> /dev/null; then
  alias alacritty="alacritty --config-file=$XDG_CONFIG_HOME/alacritty/alacritty_macOS.yml"
else
  alias alacritty="alacritty --config-file=$XDG_CONFIG_HOME/alacritty/alacritty_arch.yml"
fi

scripts=('tmux' 'neomutt' 'davmail' 'khal' 'vdirsyncer' 'statnot')

for i in "${scripts[@]}"; do
  [[ -d $XDG_CONFIG_HOME/$i/scripts ]] && path+=("$XDG_CONFIG_HOME/$i/scripts")
done

export BROWSER='brave-launcher'
