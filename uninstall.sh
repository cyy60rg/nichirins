#!/bin/zsh

INSTALL_DIR="$HOME/.zsh_functions"
ZSHRC="$HOME/.zshrc"

echo "🗑️  Starting uninstallation..."

if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Removed $INSTALL_DIR"
fi

if [ -f "$ZSHRC" ]; then
    # Removes the comment and the source line specifically
    sed -i '/# Load personal Zsh tools/d' "$ZSHRC"
    sed -i "\|\[\[ -f $INSTALL_DIR/init.zsh \]\] && source $INSTALL_DIR/init.zsh|d" "$ZSHRC"
    echo "✅ Cleaned up $ZSHRC"
fi

echo "✨ Uninstallation complete."