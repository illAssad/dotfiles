#!/bin/bash

# Preview script for tmux sessions
selection="$1"

if [ "$selection" = "[New Session]" ]; then
    echo "Create a new tmux session"
    echo ""
    echo "This will start a fresh tmux session"
    echo "in your current directory."
else
    # Extract session name (everything before first |)
    session_name=$(echo "$selection" | cut -d'|' -f1 | sed 's/[[:space:]]*$//')
    
    # Try to capture the session content
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux capture-pane -t "$session_name" -p 2>/dev/null || echo "Could not capture session content"
    else
        echo "Session '$session_name' not found"
    fi
fi