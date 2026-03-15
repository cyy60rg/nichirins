#!/bin/zsh

# Utility to analyze and search terminal history
# Usage: ./kata [option] [query]

kata() {

    # Ensure fzf is installed before running
    if ! command -v fzf &> /dev/null; then
        echo "Error: fzf is required for 'analyze'."
        return 1
    fi

    case "$1" in
        list)
            echo "--- Your Commands (Frequency) ---"
            history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | sort | uniq -c | sort -n
            ;;
        search)
            # 1. Capture the command from fzf
            # We use '1' to ensure we get the whole history
            local CMD=$(history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | sort -u | \
                  fzf --height 40% --layout=reverse --border --header="Select to STAGE command" -q "$2")

            # 2. Push to the buffer stack
            if [ -n "$CMD" ]; then
                print -z "$CMD"
            fi
            ;;
        *)
            echo "Usage: analyze {list|search [query]}"
            ;;
    esac
}
