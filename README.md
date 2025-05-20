# 🎮 Rails Tac-Toe – Jeu de Morpion Multi-joueurs

Bienvenue sur l'application **Rails Tac-Toe** !  
Ce projet Ruby on Rails propose une expérience de morpion moderne :

- Authentification sécurisée
- Parties solo ou multi-joueurs (invitation par lien)
- Rafraîchissement en temps réel grâce à Turbo Streams

---

## 🔗 Tester en ligne

🧪 Tu peux essayer l'application directement ici :  
👉 [https://rails-tac-toe.duckdns.org](https://rails-tac-toe.duckdns.org)

> Deux comptes sont prêts à l’emploi pour tester rapidement :
>
> - **Utilisateur 1** : `user1@example.com` / `password`  
> - **Utilisateur 2** : `user2@example.com` / `password`

---

## 🚀 Démarrage rapide

### 1. Lancer l'application

Assure-toi d'avoir Ruby, Bundler et les dépendances installées.

```bash
bundle install
rails db:setup
rails server
```

L'application sera accessible sur [http://localhost:3000](http://localhost:3000).

---

### 2. Connexion & Comptes de test

Deux comptes utilisateurs sont déjà créés pour tester le mode multi-joueurs :

- **Utilisateur 1**  
  Email : `user1@example.com`  
  Mot de passe : `password`

- **Utilisateur 2**  
  Email : `user2@example.com`  
  Mot de passe : `password`

---

### 3. Jouer une partie multi-joueurs

1. **Ouvre une fenêtre de navigation normale**  
   Connecte-toi avec `user1@example.com` / `password`.

2. **Ouvre une fenêtre de navigation privée**  
   Connecte-toi avec `user2@example.com` / `password`.

3. **Depuis la session du premier utilisateur**

   - Clique sur "Nouvelle partie".
   - Clique sur "Inviter un ami".
   - Copie le lien d'invitation affiché.

4. **Dans la fenêtre privée (deuxième utilisateur)**

   - Colle le lien d'invitation dans la barre d'adresse.
   - Tu rejoins automatiquement la partie.

5. **Jouez à tour de rôle**
   - Les actions de chaque joueur sont synchronisées en temps réel (Turbo Streams).
   - Le plateau se met à jour instantanément pour les deux joueurs.

---

### 4. Fonctionnalités principales

- **Parties solo** contre l'IA
- **Parties multi-joueurs** par invitation
- **Liste "Mes parties"** accessible dans le header
- **Sécurité** : seuls les joueurs concernés peuvent accéder à une partie
- **Notifications et messages flash** pour une UX fluide

---

## 🛠️ Stack & Bonnes pratiques

- Ruby on Rails 7+
- Turbo (Hotwire) pour le live update
- Authentification simple (sessions)
- Code factorisé (services, callbacks, helpers)
- Tests RSpec & FactoryBot

---

## 📸 Aperçu

<img width="744" alt="image" src="https://github.com/user-attachments/assets/29596118-4479-414a-9281-0b29b8957d51" />

---

**Bon jeu !** 👾
