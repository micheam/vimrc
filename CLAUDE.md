# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive Vim configuration repository written in Vim9 script. The configuration is modularly organized across multiple files that are sourced by the main `vimrc` file.

## Architecture

### Core Configuration Structure
- **vimrc**: Main entry point that sources all other configuration files
- **_general.vim**: General Vim settings (encoding, indentation, search, etc.)
- **_plugins.vim**: Plugin management using vim-plug with extensive plugin configurations
- **_keymaps.vim**: Key mappings and leader key configurations
- **_functions.vim**: Custom Vim9 functions
- **_filetypes.vim**: Filetype-specific configurations

### Plugin System
Uses vim-plug for plugin management. On first run, automatically downloads vim-plug if not present and installs plugins via PlugInstall.

### Language Server Support
Comprehensive LSP setup via vim-lsp with configurations for:
- Go (gopls), Rust (rust-analyzer), TypeScript/JavaScript, HTML/CSS
- Kotlin, Swift (sourcekit), C/C++ (clangd), Java (jdtls), Zig (zls)
- Protocol Buffers (bufls), Bash, OCaml, Elm, Svelte

### Directory Structure
- **plugin/**: Custom plugin files for specific functionality
- **ftplugin/**: Filetype-specific plugin configurations
- **autoload/**: Autoloaded functions and utilities
- **colors/**: Custom color schemes
- **misc/**: Additional resources (CSS for previm, etc.)
- **scripts/**: Utility scripts including Vim build script
- **spell/**: Custom spell check dictionaries

## Key Features

### Development Tools
- FZF integration for file/buffer/text searching (`<space>f`, `<space>b`, `<space>g`)
- Git integration (fugitive, gitgutter, agit)
- Language-specific testing frameworks (go-test, quickrun)
- Code completion via vimcomplete and LSP
- Real-time markdown preview with KaTeX math support

### Custom Functionality
- Auto-timestamp insertion
- Translation utilities
- Emoji support
- Folder management
- Hash utilities
- Multi-select UI widget

## Common Development Tasks

### Plugin Management
```vim
:PlugInstall    " Install new plugins
:PlugUpdate     " Update all plugins
:PlugClean      " Remove unused plugins
```

### LSP Operations
```vim
:LspInstallServer <server-name>  " Install language server
:LspStatus                       " Check server status
<F12>                           " Go to definition
K                               " Show hover info
<F10>                           " Code actions
```

### Building Vim
Use the provided script to build Vim from source:
```bash
./scripts/update-and-build-vim.sh
```

## Key Mappings

### Navigation
- `<C-h/j/k/l>`: Window navigation
- `<space>f`: FZF file search
- `<space>b`: FZF buffer search
- `<space>g`: FZF text search (ag)

### Editing
- `jj`: Escape from insert mode
- `<space>r`: QuickRun
- `gc`: Toggle comments
- `<F2>`: Insert current date
- `<F3>`: Insert current time

### Leader Key
Space (`<space>`) is configured as the leader key for most custom mappings.

## Language-Specific Notes

### Go Development
- Includes gotags support for better code navigation
- Auto-formatting with goimports
- Comprehensive test runner integration
- Custom go-test plugin for testing workflows

### Markdown
- Real-time preview with previm
- KaTeX math rendering support
- GitHub Flavored Markdown syntax
- Custom markdown support utilities

### JavaScript/TypeScript
- Prettier integration for formatting
- Advanced syntax highlighting
- Library syntax support
- TypeScript compilation support

## Testing Strategy

This repository doesn't include automated tests since it's a Vim configuration. Testing involves:
1. Loading the configuration in Vim
2. Verifying plugin functionality
3. Checking LSP server connections
4. Testing custom functions and mappings