#!/bin/bash

# Function to format time ago
time_ago() {
    local timestamp="$1"
    local now=$(date +%s)
    local diff=$((now - timestamp))
    
    if [ $diff -lt 60 ]; then
        echo "${diff}s ago"
    elif [ $diff -lt 3600 ]; then
        echo "$((diff / 60))m ago"
    elif [ $diff -lt 86400 ]; then
        echo "$((diff / 3600))h ago"
    else
        echo "$((diff / 86400))d ago"
    fi
}

# Get detailed session info
declare -A sessions_data
main_session=""
other_sessions=()

if tmux list-sessions >/dev/null 2>&1; then
    while IFS= read -r session_line; do
        session_name=$(echo "$session_line" | cut -d: -f1)
        
        # Get session creation time (activity time as proxy)
        activity=$(tmux list-sessions -F "#{session_name}:#{session_activity}" | grep "^${session_name}:" | cut -d: -f2)
        time_str=$(time_ago "$activity")
        
        # Get current directory of the session
        current_dir=$(tmux display-message -t "$session_name" -p '#{pane_current_path}' 2>/dev/null || echo "~")
        dir_name=$(basename "$current_dir")
        
        # Get window count
        window_count=$(tmux list-windows -t "$session_name" | wc -l)
        
        # Format: "session_name | ~/dir | 3 windows | 15m ago"
        formatted_line="${session_name} | ~/${dir_name} | ${window_count} windows | ${time_str}"
        
        # Store with activity timestamp for sorting
        sessions_data["$session_name"]="$activity:$formatted_line"
        
        # Separate main session
        if [ "$session_name" = "main" ]; then
            main_session="$formatted_line"
        else
            other_sessions+=("$session_name")
        fi
    done < <(tmux list-sessions 2>/dev/null)
fi

# Sort other sessions by activity (oldest first)
if [ ${#other_sessions[@]} -gt 0 ]; then
    # Sort by activity timestamp (ascending - oldest first)
    IFS=$'\n' sorted_sessions=($(
        for session in "${other_sessions[@]}"; do
            activity=$(echo "${sessions_data[$session]}" | cut -d: -f1)
            echo "$activity:$session"
        done | sort -n | cut -d: -f2-
    ))
fi

# Build final session list: oldest first (at top), then main, then [New Session]
session_list=()
if [ ${#sorted_sessions[@]} -gt 0 ]; then
    for session in "${sorted_sessions[@]}"; do
        formatted_line=$(echo "${sessions_data[$session]}" | cut -d: -f2-)
        session_list+=("$formatted_line")
    done
fi

# Add main session right before [New Session]
if [ -n "$main_session" ]; then
    session_list+=("$main_session")
fi

# Add [New Session] at the end
session_list+=("[New Session]")

# Reverse the entire list so it appears in the right order
reversed_list=()
for ((i=${#session_list[@]}-1; i>=0; i--)); do
    reversed_list+=("${session_list[i]}")
done

# Create fzf selection 
if [ ${#reversed_list[@]} -gt 1 ]; then
    choice=$(printf "%s\n" "${reversed_list[@]}" | fzf --prompt="Select tmux session: ")
else
    choice=$(printf "%s" "[New Session]" | fzf --prompt="Select tmux session: ")
fi

# Handle the choice
if [ "$choice" = "[New Session]" ] || [ -z "$choice" ]; then
    tmux new-session
else
    # Extract session name (everything before first |)
    session_name=$(echo "$choice" | cut -d'|' -f1 | sed 's/[[:space:]]*$//')
    tmux attach -t "$session_name"
fi