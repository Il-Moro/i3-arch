eval "$(starship init zsh)"

eval "$(ssh-agent -s)" >/dev/null
ssh-add -q ~/.ssh/id_ed25519 >/dev/null 2>&1 || true

# Usa il logo piccolo se la finestra è stretta, altrimenti quello normale
if [ "$COLUMNS" -lt 100 ]; then
    fastfetch --logo arch_small --structure none
else
    fastfetch --logo arch --structure none
fi

