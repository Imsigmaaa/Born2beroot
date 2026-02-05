*This project has been created as part of the 42 curriculum by xingchen.*

# Description

Le projet **Born2beRoot** a pour objectif de faire découvrir les bases de l'administration système.
Il consiste à installer et configurer un serveur (Debian ou Rocky) en respectant des règles de sécurité strictes,sans interface graphique, afin de comprendre le fonctionnement de base d'un système serveur.

Ce projet permet de réaliser plusieurs étapes clés dans la configuration d'un serveur virtuel :
- Installation de la machine virtuelle et partitionnement avec LVM chiffré
- Configuration des services de base (SSH, pare-feu)
- Gestion des utilisateurs et des permissions avec sudo
- Mise en place d'une politique de mots de passe sécurisée
- Exécution automatique de scripts via cron
- Mise en place d'un système de monitoring pour surveiller l'état du serveur

---

## Description du projet
J'ai choisi **Debian (version stable)** pour ce projet.
### Pourquoi Debian ?
**Avantages :**
- Très stable et fiable
- Documentation abondante
- Simple à administrer pour les débutants
- Large communauté

**Inconvénients :**
- Logiciels parfois moins récents que sur d'autres distributions

### Comparaisons techniques

#### Debian vs Rocky Linux
- **Debian** : plus simple, plus stable, idéale pour débuter
- **Rocky** : plus complexe, orientée entreprise, clone de RHEL

#### AppArmor vs SELinux
- **AppArmor** : plus simple à configurer, basé sur les chemins de fichiers
- **SELinux** : plus puissant mais plus complexe, basé sur des labels de sécurité

#### UFW vs firewalld
- **UFW** : simple, clair, adapté à Debian
- **firewalld** : plus flexible, utilisé sur Rocky et systèmes Red Hat

#### VirtualBox vs UTM
- **VirtualBox** : très répandu, facile à utiliser, multi-plateforme
- **UTM** : alternative sur Mac M1/M2 (architecture ARM)


# Instructions

## Prérequis
- VirtualBox (ou UTM si VirtualBox indisponible)
- ISO de Debian stable
- Aucun environnement graphique (X.org, Wayland interdits)

## Installation et configuration

### 1. Système de base

- Installer Debian en mode serveur
- Partitionnement : LVM + chiffrement
- Mise à jour système
```bash
sudo apt update 
```
### 2. Utilisateurs et groupes
- Créer utilisateur avec votre login
- Ajouter aux groupes `user42` et `sudo`
```bash
sudo adduser
sudo addgroup user42
```

### 3. Politique de mot de passe
**Expiration :** 30 jours | **Délai modification :** 2 jours | **Alerte :** 7 jours avant expiration

**Complexité :** 10 caractères min, 1 majuscule, 1 minuscule, 1 chiffre, max 3 caractères identiques consécutifs, pas de nom d'utilisateur

### 4. Configuration SSH
```bash
# Port 4242, root login désactivé
Port 4242
PermitRootLogin no
```

### 5. Pare-feu UFW
```bash
sudo ufw allow 4242
sudo ufw enable
# Seul le port 4242 ouvert
```

### 6. Configuration sudo
- 3 tentatives max
- Journalisation complète
- Mode TTY requis
- Chemins d'exécution restreints

### 7. Script monitoring.sh
**Affichage toutes les 10 min (via cron) :**
- Architecture système + version noyau
- CPU physiques/virtuels
- RAM (utilisée/totale + %)
- Disque (utilisé/total + %)
- Charge CPU (%)
- Dernier redémarrage
- État LVM
- Connexions TCP actives
- Utilisateurs connectés
- IPv4 + MAC
- Commandes sudo exécutées
```bash
# Configurer cron
sudo crontab -e
# Ajouter : */10 * * * * /path/to/monitoring.sh
```

---


# Resources

### Documentation classique
- [Debian Documentation officielle](https://www.debian.org/doc/)
- Pages de manuel : `man sudo`, `man ssh`, `man ufw`, `man cron`
- [Documentation LVM](https://tldp.org/HOWTO/LVM-HOWTO/)
- Documentation officielle de 42

### Utilisation de l'IA
L'IA a été utilisée pour :
- Clarifier certains concepts théoriques (LVM, SSH, sudo, politiques de sécurité)
- Reformuler des explications techniques pour améliorer la clarté
- Améliorer la structure et la présentation du README

**Aucune partie du code ou de la configuration du projet n'a été automatisée par l'IA.** Toute l'installation et la configuration ont été réalisées manuellement.
