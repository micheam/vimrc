Personal Vim9 configuration repository.

> [!Note]
>
> This configuration is written in Vim9script and requires Vim 9.0 or later.
> It is not compatible with Neovim or older versions of Vim.

## Installation

```bash
git clone https://github.com/micheam/vimrc.git $XDG_CONFIG_HOME/vim
```

## Structure

```
.
├── vimrc           # Main configuration entry point
├── _general.vim    # General Vim settings
├── _plugins.vim    # Plugin configurations
├── _keymaps.vim    # Key mappings
├── _functions.vim  # Custom Vim9 functions
├── _filetypes.vim  # Filetype-specific settings
├── plugin/         # Custom plugins
├── ftplugin/       # Filetype plugins
├── autoload/       # Autoloaded functions
└── scripts/        # Utility scripts
```
