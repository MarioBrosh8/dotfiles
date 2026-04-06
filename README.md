# My Dotfiles

Personal dotfiles for macOS including zsh, tmux, neovim, ghostty, and fastfetch.

## Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## What's Included

- **zsh** - Shell with Oh My Zsh, custom theme, and plugins
- **tmux** - Terminal multiplexer with TPM plugins
- **nvim** - Neovim with Kickstart config, LSP, Telescope, Treesitter
- **ghostty** - Terminal emulator config
- **fastfetch** - System info display with pixelart logo
- **git** - Git aliases and configuration

## Post-Install

1. Install TMUX plugins: `Prefix + I` inside tmux
2. Open nvim and let Lazy.nvim install plugins
3. Run `:MasonInstallAll` for LSP tools
