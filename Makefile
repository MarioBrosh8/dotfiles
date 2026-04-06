.PHONY: install link clean backup

install:
	@./install.sh

link:
	@echo "Creating symlinks..."
	@./install.sh --link-only

clean:
	@echo "Removing symlinks..."
	@rm -f ~/.zshrc ~/.zshenv ~/.zprofile ~/.tmux.conf
	@rm -f ~/.config/ghostty ~/.config/nvim ~/.config/fastfetch

backup:
	@echo "Creating backup..."
	@mkdir -p ~/.dotfiles_backup
	@cp -r ~/.zshrc ~/.zshenv ~/.zprofile ~/.tmux.conf ~/.dotfiles_backup/ 2>/dev/null
	@cp -r ~/.config/ghostty ~/.config/nvim ~/.config/fastfetch ~/.dotfiles_backup/ 2>/dev/null
	@echo "Backup complete in ~/.dotfiles_backup/"
