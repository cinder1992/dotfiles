ZSH=$HOME/.zsh
DISABLE_AUTO_TITLE="true"
# Load config files:
export EDITOR=vim

for config_file in $ZSH/(local|config|modules)/*.zsh; source $config_file
