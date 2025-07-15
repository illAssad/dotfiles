#!/bin/bash

# Kill session script for tmux session selector
selection="$1"

if [ "$selection" = "[New Session]" ]; then
    echo "Cannot delete [New Session]"
    sleep 1
    exit 1
fi

# Extract session name (everything before first |)
session_name=$(echo "$selection" | cut -d'|' -f1 | sed 's/[[:space:]]*$//')

if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux kill-session -t "$session_name" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Killed session: $session_name"
    else
        echo "Failed to kill session: $session_name"
    fi
else
    echo "Session '$session_name' not found"
fi

sleep 1