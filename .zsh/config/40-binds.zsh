# gnome-terminal keybindings
# Thanks Lyude!
bindkey "[1;5D"        backward-word                     # CTRL + Left
bindkey "[1;5C"        forward-word                      # CTRL + Right
bindkey "[3;5~"        delete-word                       # CTRL + Delete
bindkey ""             backward-kill-line                # CTRL + U
bindkey "[H"           beginning-of-line                 # Home
bindkey "[F"           end-of-line                       # End
bindkey "[3~"          delete-char                       # Delete
bindkey "[2~"          overwrite-mode                    # Insert
bindkey "[5~"          history-beginning-search-backward # Page Up
bindkey "[6~"          history-beginning-search-forward  # Page Down
bindkey "[Z"           reverse-menu-complete             # Shift + Tab
bindkey ""             backward-delete-char              # Backspace
 
# Plain VT bindings
bindkey "      "       reverse-menu-complete             # Shift + Tab
bindkey "[1~"          beginning-of-line                 # Home
bindkey "[4~"          end-of-line                       # End
 
# Vim mode bindings
bindkey -a "[1;5D"     backward-word     # CTRL + Left
bindkey -a "[1;5C"     forward-word      # CTRL + Right
bindkey -a "[3;5~"     delete-word       # CTRL + Delete
bindkey -a "[2~"       vim-insert        # Insert
bindkey -a "[H"        beginning-of-line # Home
bindkey -a "[F"        end-of-line       # End
 
# Completion options
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/completion
zstyle ':completion:*' menu select
