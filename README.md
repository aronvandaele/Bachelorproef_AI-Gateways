![Bachelorproef AI-gateways - Aron Van Daele](https://img.shields.io/badge/Bachelorproef-AI--gateways%20--%20Aron%20Van%20Daele-blue)

# Bachelorproef_AI-Gateways

Deze repository bevat alle bestanden en scripts die nodig zijn om het praktische gedeelte van deze bachelorproef lokaal op te zetten. Het doel van dit onderdeel is het veilig en gecontroleerd toegankelijk maken van LLM's (zoals OpenAI, Cohere, Mistral...) en vector databases aan de hand van de Kong AI-gateway.

## Vereisten

Zorg dat volgende tools geïnstalleerd zijn:

- Docker & Docker Compose  
- Bash (Linux/macOS of Git Bash op Windows)
- [deck](https://github.com/kong/deck) (CLI-tool van Kong)
- [Postman](https://www.postman.com/downloads/)

### deck installeren (Windows)

1. Download de juiste versie via de [releasespagina](https://github.com/kong/deck/releases)
2. Pak het bestand uit
3. Voeg de map met `deck.exe` toe aan je systeem-`PATH`

Zorg er daarnaast voor dat je de uitleg in de bachelorproef gevolgd hebt omtrent het opzetten van een control plane node binnen Konnect. Vul ook zeker het .env bestand aan met je eigen informatie zodat alles correct werkt!

## Structuur van de repository

- `config/`

Bevat het configuratiebestand `Kong_AI-Gateway_PoC.template.yml`, waarin alle services, routes en plugins gedefinieerd zijn. Dit bestand bevat een heleboel placeholders die vervangen zullen worden door de waarden, gelinkt aan de variabelen, in het `.env` bestand. Dit gebeurt aan de hand van het script genaamd `generate_PoC_config.sh`, dat zich ook in deze map bevindt. Indien dit script uitgevoerd wordt, resulteert dit in het genereren van het effectieve configuratiebestand genaamd `Kong_AI-Gateway_PoC.yml`.

    - `Kong_AI-Gateway_PoC.template.yml`

Bestand met placeholders die dus vervangen worden door de variabelen in het `.env` bestand. Dit door gebruik te maken van `generate_PoC_config.sh`.

- `generate_PoC_config.sh`

Script dat gebruikt wordt om het template configuratiebestand om te zetten naar het effectieve configuratiebestand. Dit vervangt de placeholders in het template bestand door de variabelen in het `.env` bestand en levert het bestand `Kong_AI-Gateway_PoC.yml` op.

- `.env`

Bevat alle vereiste variabelen zoals certificaten, API-keys, en andere benodigde informatie. Dit bestand moet aangevuld worden met jouw persoonlijke gegevens.

- `docker-compose.yml`

Docker-compose bestand dat gebruikt wordt om de data plane node en Redis vector database lokaal op te zetten. In dit bestand wordt ook opnieuw gebruikgemaakt van placeholders die automatisch vervangen worden door de variabelen in het `.env` bestand.

- `sync-config.sh`

Script dat gebruikt wordt om het gegenereerde configuratiebestand te synchroniseren met de control plane node binnen Konnect, gebruikmakend van `deck`.

## Opzetten praktisch gedeelte

1. **Zorg ervoor dat alle vereisten geïnstalleerd werden**

2. **Vul het `.env` bestand aan**  

Gebruik de placeholders in het bestand als leidraad. Vul alle vereiste API-keys, certificaten en resterende informatie aan.

3. **Start de containers aan de hand van het `docker-compose` bestand**

```bash
docker-compose up -d
```

4. **Genereer het configuratiebestand**

```bash
./generate_PoC_config.sh
```

Zorg ervoor dat je je hiervoor binnen de `config` map bevindt!

5. **Synchroniseer de configuraties met Konnect**

```bash
./sync-config.sh
```

Nu zou alles in orde moeten zijn en kunnen de AI-plugins aan de hand van Postman getest worden.
