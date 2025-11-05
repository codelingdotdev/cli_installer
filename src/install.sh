#!/bin/bash

# Codeling CLI Install Script

set -e

BASE_URL="https://cli.codeling.dev"

# Detect OS and architecture
detect_platform() {
    local os=""
    local arch=""
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        os="darwin"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        os="linux"
    else
        echo "Error: Unsupported OS: $OSTYPE"
        exit 1
    fi
    
    # Detect architecture (only matters for macOS)
    if [[ "$os" == "darwin" ]]; then
        arch=$(uname -m)
        if [[ "$arch" == "arm64" ]]; then
            echo "codeling-darwin-arm64"
        elif [[ "$arch" == "x86_64" ]]; then
            echo "codeling-darwin-amd64"
        else
            echo "Error: Unsupported macOS architecture: $arch"
            exit 1
        fi
    else
        # Linux (includes WSL)
        echo "codeling-linux"
    fi
}

# Main installation
main() {
    echo "Installing Codeling CLI..."
    
    # Detect which binary to download
    BINARY_NAME=$(detect_platform)
    echo "Detected platform: $BINARY_NAME"
    
    # Define installation directory
    INSTALL_DIR="$HOME/codeling/bin"
    BINARY_PATH="$INSTALL_DIR/codeling"
    
    # Create directory if it doesn't exist
    echo "Creating installation directory: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
    
    # Download the binary (with cache busting)
    DOWNLOAD_URL="$BASE_URL/$BINARY_NAME.tar.gz?t=$(date +%s)"
    echo "Downloading from: $DOWNLOAD_URL"
    
    if command -v curl >/dev/null 2>&1; then
        curl -fL -H "Cache-Control: no-cache" -H "Pragma: no-cache" "$DOWNLOAD_URL" -o "$BINARY_PATH.tar.gz"
    elif command -v wget >/dev/null 2>&1; then
        wget -q --no-cache --header="Cache-Control: no-cache" --header="Pragma: no-cache" "$DOWNLOAD_URL" -O "$BINARY_PATH.tar.gz"
    else
        echo "Error: Neither curl nor wget is available. Please install one of them."
        exit 1
    fi
    
    # Extract the binary
    echo "Extracting..."
    TEMP_DIR=$(mktemp -d)
    tar -xzf "$BINARY_PATH.tar.gz" -C "$TEMP_DIR"
    
    # Move the extracted binary to the correct location
    mv "$TEMP_DIR/$BINARY_NAME" "$BINARY_PATH"
    
    rm -rf "$TEMP_DIR"
    rm "$BINARY_PATH.tar.gz"
    
    # Make it executable
    chmod +x "$BINARY_PATH"
    echo "Binary installed to: $BINARY_PATH"
    
    # Determine shell config file
    SHELL_RC=""
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_RC="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            SHELL_RC="$HOME/.bash_profile"
        else
            SHELL_RC="$HOME/.bashrc"
        fi
    else
        SHELL_RC="$HOME/.profile"
    fi
    
    # Add to PATH if not already present
    PATH_EXPORT="export PATH=\"\$HOME/codeling/bin:\$PATH\""
    
    if [[ -f "$SHELL_RC" ]] && grep -q "codeling/bin" "$SHELL_RC" 2>/dev/null; then
        echo "PATH already configured in $SHELL_RC"
    else
        echo "" >> "$SHELL_RC"
        echo "# Codeling CLI" >> "$SHELL_RC"
        echo "$PATH_EXPORT" >> "$SHELL_RC"
        echo "Added to PATH in $SHELL_RC"
        echo ""
        echo "Please restart your shell or run: source $SHELL_RC"
    fi
    
    echo ""
    echo "✓ Installation complete!"
    echo "Run 'codeling version' to verify (after restarting your shell or sourcing $SHELL_RC)"
}

main
