# 📱 iSYSTEM — Gestion de Ventes

<p align="center">
        <img src="assets/logo.png" alt="iSYSTEM Logo" width="120" />
</p>

**iSYSTEM** est une solution de gestion commerciale mobile conçue pour les revendeurs de produits électroniques en République Démocratique du Congo. L'application mise sur une esthétique minimaliste **Noir & Blanc**, une typographie **Quicksand** épurée et une robustesse technique grâce au stockage local **SQLite**.

---

<p align="center">
        <a href="https://drive.google.com/file/d/1I36kU52D-R9Wv7N1DOemOubfJaNAst86/view?usp=drive_link">
                <strong style="font-size:1.05rem">⬇️ DOWNLOAD APK (Android)</strong>
        </a>
</p>

> ⚠️ Version de test — l'APK fournie est destinée aux tests. Elle peut contenir des bugs ou des comportements imprévus.

---

## 🔧 Tâches en cours / À finir

- Implémenter la **déconnexion** complète de l'utilisateur (suppression en base et UI).
- Lire et agréger les **données réelles du Dashboard** (CA, nombre de ventes, top produit) depuis la base locale.
- Mettre en place la **synchronisation bidirectionnelle** avec une base en ligne (gestion des conflits, états `isSynced`).
- Ajouter des **tests unitaires** et d'intégration pour `DatabaseHelper` et les providers critiques.
- Gestion des erreurs réseau et reprise des synchronisations (retries, backoff).
- Internationalisation (FR/EN) et gestion des formats monétaires locaux.
- Ajouter les assets officiels (logo, icônes) et vérifier le chargement des polices sur toutes les plateformes.

---

## ✨ Fonctionnalités Principales

### 📊 Tableau de Bord Intelligent
- **Accueil Personnalisé** : Salutations automatiques en français (*Bonjour, Bon après-midi, Bonsoir*) basées sur l'heure système.
- **Indicateurs de Performance** : Vue d'ensemble du volume de ventes et de l'état de la base de données.

### 💸 Terminal de Vente (POS)
- **Catalogue iSYSTEM** : Sélection fluide parmi 10 modèles de smartphones populaires en RDC (iPhone, Samsung, Tecno, Infinix, etc.).
- **Calcul Dynamique** : Saisie de quantité avec mise à jour instantanée du total en **CDF**.
- **Modes de Paiement** : Gestion multi-canaux (Cash, Carte, Mobile Money).

### 🔄 Historique & Synchronisation
- **Gestion SQLite** : Sauvegarde locale immédiate pour garantir un fonctionnement sans internet.
- **Filtres Avancés** : Navigation par onglets entre "TOUTES" les ventes et celles "EN ATTENTE" de synchronisation.
- **Statut de Synchro** : Indicateurs colorés (Vert/Orange) pour le suivi des données envoyées au Cloud.

### 👤 Profil & Préférences
- **Persistance des données** : Sauvegarde du nom et de l'email de l'utilisateur.
- **Apparence** : Switch Dark Mode / Light Mode géré dynamiquement.

---

## 🛠️ Architecture Technique

| Composant | Technologie |
| :--- | :--- |
| **Framework** | Flutter (Dart) |
| **State Management** | Provider |
| **Base de données** | SQLite (Sqflite) |
| **Police** | Quicksand (chargée localement) |
| **Design** | Monochrome High-Contrast (Noir & Blanc) |

---

## 🚀 Installation & Lancement

### 1. Prérequis
- Flutter SDK (v3.10.0 ou plus récent)
- Un terminal avec Git configuré
- Un émulateur ou appareil physique

### 2. Récupération du projet
```bash
git clone https://github.com/glosings0n/iSYSTEM.git
cd iSYSTEM
```

### 3. Gestion des Polices

Pour respecter la charte graphique **iSYSTEM**, téléchargez la police **Quicksand** et placez les fichiers dans :
`assets/fonts/Quicksand-Regular.ttf`
`assets/fonts/Quicksand-Bold.ttf`

### 4. Installation des modules

```bash
flutter pub get
```

### 5. Lancement

```bash
flutter run
```

---

## 📁 Organisation des Dossiers

```text
assets/      # Fonts et images locales
lib/
├── core/
        ├── database/          # DatabaseHelper (Connexion et Requêtes SQL)
        ├── models/            # Structures (UserModel, SaleModel, ProductModel)
        ├── providers/         # Logique d'état (UserProvider, SalesProvider, ...)
        ├── autres dossiers/   # Styles (Theme, Icons, ...)
├── features/          # Interface (screens) (Host, Dashboard, NewSale, SalesList)
└── main.dart          # Configuration initiale 

```

---

## 🗄️ Structure de la base de données

L'application initialise automatiquement le schéma suivant :

* **Table `users`** : Profil utilisateur et préférences.
* **Table `products`** : Référentiel des prix et modèles.
* **Table `sales`** : Registre complet des transactions, avec un ID unique.

---

## 🤝 Contribution

1. Forkez le projet **iSYSTEM**.
2. Créez votre branche (`git checkout -b feature/NomDeMaFonction`).
3. Commitez vos changements (`git commit -m 'Ajout de ...'`).
4. Pushez vers la branche (`git push origin feature/NomDeMaFonction`).
5. Ouvrez une Pull Request.

---

## 📄 Licence

Propriété d'**iSYSTEM**.

---
## 👨‍💻 Développé par

**Georges Byona** - Software Engineer & Tech Community Lead  
Socials Handle: [@glosings0n](https://linktr.ee/glosings0n)
