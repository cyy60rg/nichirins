#!/bin/zsh

# Utility to analyze and search terminal history
# Usage: ./kata [option] [query]

kata() {

    # Manual/Help Content
    _kata_usage() {
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

    # Check the first argument provided to the function
    case "$1" in
        # Match either the short flag (-l) or the long flag (--list)
        -l|--list)

            # 1. history 1: Get the entire history starting from the first entry
            # 2. sed 's/^ *[0-9]* *//': Remove the leading line numbers provided by the history command
            # 3. sed 's/^: [0-9]*:[0-9]*;//': Remove Zsh extended history timestamps (e.g., : 1710500000:0;)
            # 4. awk '{print $1}': Extract only the first word (the command name) from each line
            # 5. sort: Group identical commands together
            # 6. uniq -c: Count the number of occurrences for each command
            # 7. sort -n: Sort the list numerically so the most used commands appear at the bottom
            history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | awk '{print $1}' | sort | uniq -c | sort -n
            ;;

        # Match either the short flag (-s) or the long flag (--search)    
        -s|--search)

            # local CMD: Create a variable scoped only to this function
            # history 1: Fetch the command history
            # sed: Clean line numbers and Zsh timestamps (same as above)
            # sort -u: Remove duplicate lines so the fzf list is clean and unique
            # fzf: Open the fuzzy finder interface with specific UI settings
            # -q "$2": Pre-fill the fzf search bar with the second argument if provided
            local CMD=$(history 1 | sed 's/^ *[0-9]* *//; s/^: [0-9]*:[0-9]*;//' | sort -u | \
                  fzf --height 40% --layout=reverse --border --header="Select to STAGE command" -q "$2")
            
            # Check if the CMD variable is not empty (i.e., the user didn't hit ESC in fzf)
            if [[ -n "$CMD" ]]; then
                # print -z: Push the selected command string into the shell's editing buffer
                print -z "$CMD"
            fi
            ;;

        # Match help flags or any other input (*) that doesn't match the cases above    
        -h|--help|*)
        
            # Execute the usage/manual function defined earlier
            _kata_usage
            ;;
    esac
}
