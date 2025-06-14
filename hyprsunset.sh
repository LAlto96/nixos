#!/usr/bin/env bash

# Coordonnées de Bouc-Bel-Air
LAT=43.452
LON=5.413
TIMEZONE="Europe/Paris"

# Obtenir l'heure du coucher du soleil en UTC
sunset_utc=$(curl -s "https://api.sunrisesunset.io/json?lat=$LAT&lng=$LON&date=today&timezone=$TIMEZONE" | jq -r '.results.sunset')

# Convertir l'heure du coucher du soleil en format UNIX
sunset_unix=$(date -d "$sunset_utc" +%s)

# Heure actuelle en format UNIX
current_time=$(date +%s)

# Calculer le délai jusqu'au coucher du soleil
delay=$((sunset_unix - current_time))

# Attendre jusqu'au coucher du soleil
sleep $delay

# Appliquer le filtre Hyprsunset
hyprctl hyprsunset temperature 4000
