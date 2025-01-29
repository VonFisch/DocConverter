#!/bin/bash

# Configuration
TEMPLATE_DIR="./templates"
OUTPUT_DIR="./output"
CONFIG_DIR="./config"

# Création des dossiers nécessaires
mkdir -p "$OUTPUT_DIR"/{pdf,html,temp}

process_markdown() {
    local input_file="$1"
    local filename=$(basename "$input_file" .md)
    
    # Traitement des diagrammes PlantUML
    echo "Processing PlantUML diagrams in $input_file..."
    grep -n "@startuml" "$input_file" | while read -r line; do
        plantuml -tsvg "$input_file"
    done
    
    # Traitement des diagrammes Mermaid
    echo "Processing Mermaid diagrams in $input_file..."
    if grep -q "```mermaid" "$input_file"; then
        mmdc -i "$input_file" -o "$OUTPUT_DIR/temp/${filename}_diagrams.svg"
    fi
    
    echo "Converting to HTML..."
    pandoc "$input_file" \
        --from markdown \
        --to html \
        --template="$TEMPLATE_DIR/template.html" \
        --css="$TEMPLATE_DIR/styles.css" \
        --highlight-style=tango \
        --self-contained \
        -o "$OUTPUT_DIR/html/${filename}.html"
    
    pandoc "$input_file" \
    --defaults="$CONFIG_DIR/pandoc.yaml" \
    -o "$OUTPUT_DIR/pdf/${filename}.pdf"
}

# Traitement des arguments
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <markdown_file> [markdown_file...]"
    exit 1
fi

# Traitement de chaque fichier
for file in "$@"; do
    if [ -f "$file" ] && [ "${file##*.}" = "md" ]; then
        process_markdown "$file"
    else
        echo "Skipping $file - not a markdown file"
    fi
done