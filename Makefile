# Makefile per il setup automatico di i3 e dotfiles

.PHONY: all install-pkgs install-aur deploy-configs clean

# Bersaglio principale: fa tutto in sequenza (inclusi i pacchetti AUR)
all: install-pkgs install-aur deploy-configs

# 1. Installazione dei pacchetti da packages.txt
install-pkgs:
	@echo "========================================="
	@echo " Installazione pacchetti da packages.txt "
	@echo "========================================="
	sudo pacman -Syu --needed --noconfirm $$(cat packages.txt)

# 1b. Installazione dei pacchetti AUR da packages-aur.txt
install-aur:
	@echo "========================================="
	@echo " Installazione pacchetti da packages-aur.txt "
	@echo "========================================="
	@if ! command -v yay > /dev/null; then \
		echo "➜ yay non trovato. Lo compilo al volo..."; \
		git clone https://aur.archlinux.org/yay.git /tmp/yay && \
		cd /tmp/yay && makepkg -si --noconfirm; \
	fi
	yay -S --needed --noconfirm $$(cat packages-aur.txt)

# 2. Copia pulita delle configurazioni nella Home
deploy-configs:
	@echo "========================================="
	@echo " Copia dei file di configurazione...     "
	@echo "========================================="
	# Crea le cartelle e file
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/.config/i3 
	mkdir -p $(HOME)/.config/kitty 
	mkdir -p $(HOME)/.config/polybar 
	mkdir -p $(HOME)/.config/yazi 
	mkdir -p $(HOME)/.config/rofi
	touch $(HOME)/.zshrc
	touch $(HOME)/.xinitrc

	# Copia le cartelle dentro .config (sovrascrive se già esistono)
	cp -rf .config/i3 $(HOME)/.config/
	cp -rf .config/kitty $(HOME)/.config/
	cp -rf .config/polybar $(HOME)/.config/
	cp -rf .config/yazi $(HOME)/.config/
	cp -rf .config/rofi $(HOME)/.config/
	
	# Copia i file singoli nella Home
	cp -f .config/.starship.toml
	cp -f .zshrc $(HOME)/.zshrc
	cp -f .xinitrc $(HOME)/.xinitrc
	
	@echo "Setup completato con successo!"