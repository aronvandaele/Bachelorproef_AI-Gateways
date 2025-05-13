#!/bin/bash
    
echo "Genereren van het configuratiebestand voor de PoC: Kong_AI-Gateway_PoC.yml"

# Inladen variabelen uit .env bestand
set -a # Alle volgende variabelen definiëren als omgevingsvariabelen
source ../Using-Konnect/.env # Inladen .env bestand -> NOG VERVANGEN VOOR GIT REPO

# Vervangen placeholders binnen Kong_AI-Gateway_PoC.template.yml en nieuwe file genereren met de echte variabelen
envsubst < Kong_AI-Gateway_PoC.template.yml > Kong_AI-Gateway_PoC.yml
   
echo "Testconfiguratie gegenereerd: Kong_AI-Gateway_PoC.yml"