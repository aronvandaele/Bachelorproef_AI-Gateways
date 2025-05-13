#!/bin/bash

# Je kan dit script opnieuw uitvoeren telkens je de YAML-configuratie aanpast en wil synchroniseren met je control plane node binnen Konnect.

# Dit zorgt ervoor dat het script stopt bij de eerste fout
set -e

echo "Syncen van AI Gateway configuratie naar Konnect..."

# Checken of er een .env bestand bestaat
if [ ! -f .env ]; then
  echo ".env bestand niet gevonden. Zorg dat dit in dezelfde map staat als dit script."
  exit 1
fi

# De inhoud van het .env bestand inladen
source .env

# Controleren of de noodzakelijke variabelen correct ingevuld zijn
if [[ -z "$KONNECT_PAT" || -z "$DECK_KONNECT_CONTROL_PLANE_NAME" ]]; then
  echo "KONNECT_PAT of DECK_KONNECT_CONTROL_PLANE_NAME ontbreekt in je .env bestand."
  echo "Voeg ze toe zodat Konnect weet wie je bent en waar de configuratie ingeladen moet worden."
  exit 1
fi

# Om met 'deck' verbinding te maken met Konnect moet je twee environment variables instellen
#  - DECK_KONNECT_TOKEN: je persoonlijke toegangstoken (PAT)
#  - DECK_KONNECT_CONTROL_PLANE_NAME: naam van de control plane zoals in Konnect
export DECK_KONNECT_TOKEN="$KONNECT_PAT"
export DECK_KONNECT_CONTROL_PLANE_NAME="$DECK_KONNECT_CONTROL_PLANE_NAME"

# Hier wordt de sync met Konnect uitgevoerd aan de hand van 'deck'
#  - De configuratie file(s) binnen 'config' worden verstuurd naar de Control Plane Node binnen Konnect
#  - Hierdoor worden de services, routes en plugins geactiveerd op de gevraagde Kong gateway
echo "deck sync wordt uitgevoerd..."
for yaml_file in config/*.yml; do
  echo "Syncen van ${yaml_file}..."
  deck gateway sync --konnect-addr https://eu.api.konghq.com "$yaml_file"
done

# Als alles goed gaat krijg je deze melding
echo "Sync compleet! Je configuratie is nu live binnen Konnect."