@echo off
REM Rio Mundo — visualizar antes do commit (duplo clique)
cd /d "%~dp0"
echo === Rio Mundo: gerando build... ===
REM Limpa o cache de conteúdo do Astro para evitar avisos de "Duplicate id"
REM ao publicar artigos novos (cache regenerado automaticamente no build).
if exist "node_modules\.astro\data-store.json" del /q "node_modules\.astro\data-store.json"
call "C:\Program Files\nodejs\npm.cmd" run build
if errorlevel 1 (
  echo FALHOU o build. Veja o erro acima.
  pause
  exit /b 1
)
echo.
echo === Abrindo preview em http://localhost:4321 ===
start http://localhost:4321
call "C:\Program Files\nodejs\npm.cmd" run preview -- --port 4321 --host 127.0.0.1
pause
