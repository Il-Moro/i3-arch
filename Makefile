# Makefile per il setup automatico di i3 e dotfiles

.PHONY: all install-pkgs deploy-configs clean

# Bersaglio principale: fa tutto in sequenza
all: install-pkgs deploy-configs

# 1. Installazione dei pacchetti da packages.txt
install-pkgs:
	@echo "========================================="
	@echo " Installazione pacchetti da packages.txt "
	@echo "========================================="
	sudo pacman -Syu --needed --noconfirm $$(cat packages.txt)

# 2. Copia pulita delle configurazioni nella Home
deploy-configs:
	@echo "========================================="
	@echo " Copia dei file di configurazione...     "
	@echo "========================================="
	# Crea la cartella .config nella Home se non esiste
	mkdir -p $(HOME)/.config
	
	# Copia le cartelle dentro .config (sovrascrive se già esistono)
	cp -rf .config/i3 $(HOME)/.config/
	cp -rf .config/kitty $(HOME)/.config/
	cp -rf .config/polybar $(HOME)/.config/
	cp -rf .config/yazi $(HOME)/.config/
	cp -rf .config/rofi $(HOME)/.config/
	
	# Copia i file singoli nella Home
	cp -f .zshrc $(HOME)/.zshrc
	cp -f .xinitrc $(HOME)/.xinitrc
	
	@echo "Setup completato con successo!"

# Pulizia opzionale (se vuoi rimuovere i file dalla Home, usa con cautela)
clean:
	@echo "Rimozione configurazioni installate..."
	rm -rf $(HOME)/.config/i3
	rm -rf $(HOME)/.config/kitty
	rm -rf $(HOME)/.config/polybar
	rm -rf $(HOME)/.config/yazi
	rm -rf $(HOME)/.config/rofi
	rm -f $(HOME)/.zshrc
	rm -f $(HOME)/.xinitrc