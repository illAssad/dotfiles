set -gx PATH /usr/bin $PATH

if status is-interactive
    # Set default editor
    set -gx EDITOR nvim
    
    # Catppuccin Mocha theme colors
    set -g fish_color_normal cdd6f4
    set -g fish_color_command 89b4fa
    set -g fish_color_param f2cdcd
    set -g fish_color_keyword f38ba8
    set -g fish_color_quote a6e3a1
    set -g fish_color_redirection f5c2e7
    set -g fish_color_end fab387
    set -g fish_color_comment 6c7086
    set -g fish_color_error f38ba8
    set -g fish_color_gray 6c7086
    set -g fish_color_selection --background=414559
    set -g fish_color_search_match --background=414559
    set -g fish_color_operator f5c2e7
    set -g fish_color_escape eba0ac
    set -g fish_color_autosuggestion 6c7086
    set -g fish_color_cancel f38ba8
    set -g fish_color_completion cdd6f4
    set -g fish_color_cwd f9e2af
    set -g fish_color_cwd_root f38ba8
    set -g fish_color_host 89b4fa
    set -g fish_color_host_remote a6e3a1
    set -g fish_color_status f38ba8
    set -g fish_color_user 94e2d5
    set -g fish_color_valid_path --underline
    set -g fish_pager_color_progress 6c7086
    set -g fish_pager_color_background
    set -g fish_pager_color_prefix 89b4fa
    set -g fish_pager_color_completion cdd6f4
    set -g fish_pager_color_description 6c7086
    set -g fish_pager_color_selected_background --background=414559
    set -g fish_pager_color_selected_prefix f38ba8
    set -g fish_pager_color_selected_completion f38ba8
    set -g fish_pager_color_selected_description f38ba8
    
    # Aliases for common commands
    alias ll 'ls -la'
    alias la 'ls -A'
    alias grep 'grep --color=auto'
    
    # Git aliases
    alias g 'git'
    alias ga 'git add'
    alias gc 'git commit'
    alias gp 'git push'
    alias gs 'git status'
    alias gd 'git diff'
    alias gl 'git log --oneline'
    
    # Directory navigation
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'
    
    # Development aliases
    alias vim 'nvim'
    alias cat 'batcat'
    alias ls 'eza --icons'
    alias tree 'eza --tree'
    
    # Enable vi mode
    fish_vi_key_bindings
    
    # Configure ghq root
    set -gx GHQ_ROOT $HOME/Dev

    # Initialize zoxide to override cd
    zoxide init --cmd cd fish | source
end

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv | source)
