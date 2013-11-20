
# this is an example configuration file for zsh powerline prompt. it shows
# various configuration features and some hooks which you may or may not find
# helpful, and which are supported by the powerline prompt.

# add the directory this file resides in to fpath
fpath+=( $ZSH/prompt )

# initialize the prompt contrib
autoload promptinit && promptinit

### additional zstyles

# set some fixed host colors
zstyle ':prompt:*:twilight*'    host-color 093
zstyle ':prompt:*:pinkie*'      host-color 201
zstyle ':prompt:*:rarity'       host-color white
zstyle ':prompt:*:applejack'    host-color 208
zstyle ':prompt:*:fluttershy'   host-color 226


# only show username on remote server or if it's different from my default
[[ -n $SSH_CONNECTION || $USER == valodim ]] && zstyle ':prompt:powerline:ps1' hide-user 1

# enable check-for-changes, for the ¹² indicators in git
zstyle ':vcs_info:*:powerline:*' check-for-changes true

zstyle ':prompt:powerline:ps1' sep1-char ''
zstyle ':prompt:powerline:ps1' sep2-char ''
zstyle ':prompt:powerline:ps1' lock-char ''
zstyle ':prompt:powerline:ps1' branch-char ''

### load some optional hooks which add further functionality. uncomment to enable.

# disambiguate the pathname instead of last three elements (/u/s/z/functions -> share/zsh/functions)
 #source $ZSH/prompt/hooks/prompt-disambiguate.zsh

# show signal names instead of exit codes based on a heuristic (130 -> INT)
 #source $ZSH/prompt/hooks/prompt-exitnames.zsh

# show commits ahead/behind of tracking branch, and number of stashed commits
 #source $ZSH/prompt/hooks/vcs_info-githooks.zsh

# show lo-fi version of vcs info, saving load times in exchange for information
# source hooks/vcs_info-lofi.zsh


### done with configuration - actually select the prompt

prompt powerline

