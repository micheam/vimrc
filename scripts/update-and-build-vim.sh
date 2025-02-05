#!/bin/bash -e

# Configuration
VIM_REPO_DIR="$(ghq root)/github.com/vim/vim"
INSTALL_PREFIX="/usr/local"
LUAJIT_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}/Cellar/luajit/2.1.1736781742"

# Function to print messages
# shellcheck disable=SC2034
log() {
    local msg="${1:?}"
    local COLOR_RESET="\e[0m"
    local COLOR_INFO="\e[1;32m"   # Green for INFO
    local COLOR_WARN="\e[1;33m"   # Yellow for WARN
    local COLOR_ERROR="\e[1;31m"  # Red for ERROR

    printf "%b[INFO] %s%b\n" "$COLOR_INFO" "$msg" "$COLOR_RESET"
}

# Ensure the Vim repository exists
if [ ! -d "$VIM_REPO_DIR" ]; then
    echo "[ERROR] Vim repository not found at $VIM_REPO_DIR"
    exit 1
fi

# Navigate to the Vim repository
cd "$VIM_REPO_DIR"

# Update the repository
log "Pulling the latest Vim source code..."
git pull

# Clean previous build artifacts
log "Cleaning previous build artifacts..."
sudo make distclean
log "No previous build artifacts to clean."

# Configure the build
log "Configuring the build..."
./configure --prefix="$INSTALL_PREFIX" \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp \
    --enable-fail-if-missing \
    --enable-luainterp \
    --with-luajit \
    --with-lua-prefix="$LUAJIT_PREFIX"

# Build and install
log "Building Vim..."
make -j"$(nproc)"

log "Installing Vim..."
sudo make install

log "## Vim has been successfully updated and installed!! ##"
log "$(vim --version | head -1)"
