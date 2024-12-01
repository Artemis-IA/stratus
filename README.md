# Projet Stratus

Le projet **Stratus** vise à fournir une infrastructure complète pour le déploiement sécurisé d'applications web, en intégrant des services essentiels tels que la gestion des identités, la supervision, le proxy inverse et la gestion des secrets.

## Table des matières

1. [Présentation](#présentation)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Sécurité](#sécurité)
5. [Intégration Continue](#intégration-continue)
6. [Contributions](#contributions)
7. [Licence](#licence)

## Présentation

Stratus combine plusieurs services pour créer une infrastructure robuste et sécurisée :

- **Authelia** : Solution d'authentification multifactorielle pour protéger les applications web.
- **Gatus** : Outil de surveillance pour vérifier la disponibilité et les performances des services.
- **Traefik** : Proxy inverse et load balancer dynamique pour gérer le trafic entrant.
- **Vault** : Gestionnaire de secrets pour stocker et contrôler l'accès aux informations sensibles.

## Installation

Pour installer et déployer Stratus, suivez les étapes ci-dessous :

1. **Cloner le dépôt** :

   ```bash
   git clone https://github.com/Artemis-IA/stratus.git
   cd stratus
   ```

2. **Configurer les variables d'environnement** :

   Copiez le fichier `.env.example` en `.env` et modifiez les valeurs selon vos besoins.

   ```bash
   cp .env.example .env
   ```

3. **Lancer les services** :

   Utilisez Docker Compose pour démarrer l'ensemble des services.

   ```bash
   docker-compose up -d
   ```

## Configuration

Chaque service peut être configuré individuellement :

- **Authelia** : Les configurations se trouvent dans `authelia/config/configuration.yml`.
- **Gatus** : Les paramètres sont définis dans `gatus/config/config.yaml`.
- **Traefik** : Les règles dynamiques sont dans `traefik/traefik-dynamic.yml`.

Assurez-vous que les fichiers de configuration correspondent à votre environnement et à vos besoins spécifiques.

## Sécurité

Stratus intègre plusieurs mesures de sécurité :

- **Gestion des secrets** : Utilisation de Vault pour stocker et gérer les secrets de manière sécurisée.
- **Authentification** : Mise en place d'Authelia pour une authentification multifactorielle.
- **Certificats SSL** : Traefik est configuré pour utiliser Let's Encrypt et fournir des certificats SSL.

De plus, une attention particulière est portée à l'éco-conception et aux bonnes pratiques de développement sécurisé.

## Intégration Continue

Une pipeline d'intégration continue est mise en place pour assurer la qualité du code et la sécurité des informations :

- **Scan des secrets** : Utilisation de GitLeaks pour détecter les secrets potentiels dans le code.

  ```yaml
  name: Secret Scan

  on:
    push:
      branches:
        - main

  jobs:
    secret-scan:
      runs-on: ubuntu-latest
      steps:
        - name: Checkout code
          uses: actions/checkout@v3

        - name: Install GitLeaks
          run: |
            curl -sSL https://github.com/gitleaks/gitleaks/releases/download/v8.17.0/gitleaks_$(uname -s)_$(uname -m).tar.gz | tar -xvz
            sudo mv gitleaks /usr/local/bin

        - name: Run GitLeaks
          run: gitleaks detect --report-path=gitleaks-report.json
  ```

Cette configuration permet de scanner automatiquement le code à chaque push sur la branche `main` et de générer un rapport en cas de détection de secrets.

---