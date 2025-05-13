#!/bin/bash
    
echo "Genereren van het configuratiebestand: Kong_AI-Gateway_PoC.yml"

# Inladen variabelen uit .env bestand
set -a # Alle volgende variabelen definiëren als omgevingsvariabelen
source .env # Inladen .env bestand

# Vervangen placeholders binnen Kong_AI-Gateway_PoC.template.yml en nieuwe file genereren met de echte variabelen
envsubst < config/Kong_AI-Gateway_PoC.template.yml > config/Kong_AI-Gateway_PoC.yml
   
echo "Configuratiebestand gegenereerd: Kong_AI-Gateway_PoC.yml"