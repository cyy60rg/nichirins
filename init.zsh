# ~/.zsh_functions/init.zsh

# Define the source directory relative to this file
FUNC_SRC_DIR="${0:h}/src"

# Loop through all .zsh files in the src folder and source them
if [ -d "$FUNC_SRC_DIR" ]; then
    for func_file in "$FUNC_SRC_DIR"/*.zsh; do
        source "$func_file"
    done
fi