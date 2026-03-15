#!/bin/zsh

INSTALL_DIR="$HOME/.zsh_functions"
ZSHRC="$HOME/.zshrc"

# --- CHECK FOR UNINSTALL FLAG ---
if [[ "$1" == "--uninstall" || "$1" == "-u" ]]; then
    if [[ -f "./uninstall.sh" ]]; then
        chmod +x ./uninstall.sh
        ./uninstall.sh
        exit 0
    else
        echo "❌ Error: uninstall.sh not found in current directory."
        exit 1
    fi
fi

# --- INSTALLATION LOGIC ---
echo "🚀 Installing Zsh tools..."

# Create structure
mkdir -p "$INSTALL_DIR/src"

# Copy files from your repo to the home folder
cp init.zsh "$INSTALL_DIR/init.zsh"
cp tsuba/*.zsh "$INSTALL_DIR/src/"

# Add to .zshrc if not present
if ! grep -q "$INSTALL_DIR/init.zsh" "$ZSHRC"; then
    echo -e "\n# Load personal Zsh tools\n[[ -f $INSTALL_DIR/init.zsh ]] && source $INSTALL_DIR/init.zsh" >> "$ZSHRC"
    echo "✅ Added loader to .zshrc"
fi

echo "🎉 Done! Run 'source ~/.zshrc' or restart your terminal."