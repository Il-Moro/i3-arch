#!/usr/bin/env bash

# Termina eventuali istanze già avviate
killall -q i3bar
killall -q polybar

# Attendi che i processi siano stati terminati
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Lancia la barra chiamata "main" definita nel config.ini
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar lanciata con successo..."