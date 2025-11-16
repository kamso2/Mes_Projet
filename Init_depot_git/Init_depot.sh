#!/bin/bash

# Demande des informations à l'utilisateur
read -p "Nom du projet : " project_name
read -p "URL du dépôt GitHub (HTTPS ou SSH) : " repo_url

# Création du dossier et initialisation Git
mkdir -p "$project_name"
cd "$project_name" || exit

git init

echo "# $project_name" > README.md

git add .
git commit -m "Initial commit"

# Configuration du remote
if git remote | grep origin > /dev/null; then
    git remote remove origin
fi
git remote add origin "$repo_url"

# Création de la branche principale et push
branch_name="main"
git branch -M "$branch_name"
git push -u origin "$branch_name"

echo "
✅ Projet '$project_name' initialisé et poussé sur GitHub avec succès !"
