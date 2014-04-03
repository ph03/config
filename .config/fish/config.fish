# Path to your oh-my-fish.
set fish_path $HOME/.local/pkg/oh-my-fish

# Theme
set fish_theme ph03

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

set SHELL /bin/fish
set PATH $HOME/.local/bin $PATH
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# gem path
if which gem ruby > /dev/null;
  set PATH (ruby -rubygems -e 'puts Gem.user_dir')/bin $PATH;
end

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
