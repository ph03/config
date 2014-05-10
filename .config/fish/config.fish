# Path to your oh-my-fish.
set fish_path $HOME/.local/pkg/oh-my-fish

# Theme
set fish_theme ph03

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# env vars
set -x SHELL /bin/fish
set -x PATH $HOME/.local/bin $PATH
set -x PROJVC $HOME/ProjVC
set -x PROJMPI $HOME/ProjMPI
set -x GCC_COLORS auto
set -x NINJA_STATUS "[%r/%u/%f/%t] "

# aliases
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# gem path
if which gem ruby > /dev/null;
  set -x PATH (ruby -rubygems -e 'puts Gem.user_dir')/bin $PATH;
end

# nvm-fish github.com/Alex7Kom/nvm-fish
test -s /home/jmartine/.nvm-fish/nvm.fish; and source /home/jmartine/.nvm-fish/nvm.fish

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
