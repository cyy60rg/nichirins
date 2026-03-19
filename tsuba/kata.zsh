#!/bin/zsh

# Utility to analyze and search terminal history
# Usage: ./kata [option] [query]

kata() {

    # Manual/Help Content
    _kats_usage() {
        echo "NAME"
        echo "    kata - A history analysis and staging tool"
        echo ""
        echo "SYNOPSIS"
        echo "    kata [OPTION] [QUERY]"
        echo ""
        echo "DESCRIPTION"
        echo "    -l, --list      Show top used commands by frequency"
        echo "    -s, --search    Search history with fzf and stage the result"
        echo "    -h, --help      Show this manual"
    }

    case "$1" in
        -l|--list)
            history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | sort | uniq -c | sort -n
            ;;
        -s|--search)
            # Fuzzy search and stage
            local CMD=$(history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | sort -u | \
                  fzf --height 40% --layout=reverse --border --header="Select to STAGE command" -q "$2")
            
            if [[ -n "$CMD" ]]; then
                print -z "$CMD"
            fi
            ;;
        -h|--help|*)
            _analyze_usage
            ;;
    esac
}
