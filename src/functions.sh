#!/bin/bash

check_dependencies() {
    local dependencies=("pandoc" "plantuml" "mmdc" "xelatex")
    local missing=()
    
    for cmd in "${dependencies[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo "Missing dependencies: ${missing[*]}"
        echo "Please install missing dependencies"
        exit 1
    fi
}

cleanup_temp() {
    rm -rf "./output/temp"
}