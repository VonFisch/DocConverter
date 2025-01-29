#!/bin/bash

# Charger les fonctions utilitaires
source "./src/functions.sh"

# Vérifier les dépendances
check_dependencies

# Trouver tous les fichiers markdown
find . -name "*.md" -not -path "./output/*" -not -path "./node_modules/*" | while read -r file; do
    ./src/convert.sh "$file"
done

# Nettoyage
cleanup_temp