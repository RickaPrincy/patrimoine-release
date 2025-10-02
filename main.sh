#!/bin/bash

# --- Configuration ---
LAST_VERSION="0.2.1" # put here the latest version number
LINK=""              # put here the download link

JAR_NAME="patrimoine@${LAST_VERSION}.jar"
USER_DIR="$HOME"

cd "$USER_DIR" || { echo "Impossible d'accéder au dossier $USER_DIR"; exit 1; }

echo "Vérification de la présence du fichier patrimoine.jar dans $USER_DIR..."

# Find existing jar files matching the pattern
EXISTING_JAR=$(ls patrimoine@*.jar 2>/dev/null | head -n 1)

if [ -n "$EXISTING_JAR" ]; then
    CURRENT_VERSION=$(echo "$EXISTING_JAR" | cut -d "@" -f 2 | cut -d "." -f 1-3)
    if [ "$CURRENT_VERSION" = "$LAST_VERSION" ]; then
        echo "Vous avez déjà la dernière version : $LAST_VERSION"
    else
        echo "Ancienne version détectée : $CURRENT_VERSION. Suppression et téléchargement de la version $LAST_VERSION..."
        rm -f "$EXISTING_JAR"
        curl -L -o "$JAR_NAME" "$LINK"
    fi
else
    echo "Aucune version détectée. Téléchargement de la version $LAST_VERSION..."
    curl -L -o "$JAR_NAME" "$LINK"
fi

# Check if the jar file was downloaded successfully
if [ -f "$JAR_NAME" ]; then
    echo "Lancement de $JAR_NAME..."
    java -jar "$JAR_NAME"
else
    echo "Erreur : le fichier $JAR_NAME n'a pas pu être téléchargé."
    exit 1
fi