@echo off
setlocal EnableDelayedExpansion

set TEMPLATE_DIR=templates
set OUTPUT_DIR=output
set CONFIG_DIR=config

if "%~1"=="" (
    echo Usage: %0 ^<markdown_file^>
    exit /b 1
)

for %%F in (%*) do (
    if "%%~xF"==".md" (
        echo Processing %%F...
        pandoc "%%F" ^
            --defaults="%CONFIG_DIR%\pandoc.yaml" ^
            -o "%OUTPUT_DIR%\pdf\%%~nF.pdf"
    )
)