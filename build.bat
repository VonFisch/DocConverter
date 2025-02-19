@echo off
set TEMPLATE_DIR=templates
set OUTPUT_DIR=output
set CONFIG_DIR=config

if not exist "%OUTPUT_DIR%\pdf" mkdir "%OUTPUT_DIR%\pdf"
if not exist "%OUTPUT_DIR%\html" mkdir "%OUTPUT_DIR%\html"

call src\convert.bat %*