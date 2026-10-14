@echo off
REM Rio Mundo - previa de rascunhos com duplo clique.
REM COPIA (sem mover) o que esta em "Para publicar" para o lugar certo
REM e sobe o servidor de desenvolvimento. NADA e commitado nem publicado.
REM Gostou do resultado? Rode publicar.bat. Nao gostou? Edite o .md em
REM "Para publicar\Textos" e rode esta previa de novo. Para descartar um
REM rascunho, apague de "Para publicar" E a copia em src\content\colunas.
cd /d "%~dp0"

set "IN_TXT=Para publicar\Textos"
set "IN_IMG=Para publicar\Imagens"
set "IN_AUD=Para publicar\Audios"
set "OUT_TXT=src\content\colunas"
set "OUT_IMG=public\imagens"
set "OUT_AUD=public\audio"
set "NPM=C:\Program Files\nodejs\npm.cmd"

if not exist "%OUT_TXT%" mkdir "%OUT_TXT%"
if not exist "%OUT_IMG%" mkdir "%OUT_IMG%"
if not exist "%OUT_AUD%" mkdir "%OUT_AUD%"

setlocal EnableDelayedExpansion
set COPIADOS=0

echo === Levando rascunhos para a previa (copia, sem mover) ===
call :Copiar "%IN_TXT%" "%OUT_TXT%" "*.md"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.png"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.jpg"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.jpeg"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.webp"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.gif"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.avif"
call :Copiar "%IN_IMG%" "%OUT_IMG%" "*.svg"
call :Copiar "%IN_AUD%" "%OUT_AUD%" "*.mp3"
echo.
echo !COPIADOS! arquivo(s) na previa.

set "SLUG="
for %%F in ("%IN_TXT%\*.md") do (
  set "SLUG=%%~nF"
  goto ACHOU
)
:ACHOU

if exist "node_modules\.astro\data-store.json" del /q "node_modules\.astro\data-store.json"

echo.
echo === Subindo a previa (nova janela) ===
start "Previa Rio Mundo - feche esta janela para parar" /d "%CD%" "%NPM%" run dev -- --port 4321
echo Aguardando o servidor...
timeout /t 8 /nobreak >nul
if defined SLUG (
  echo Abrindo http://localhost:4321/coluna/!SLUG!
  start http://localhost:4321/coluna/!SLUG!
) else (
  echo Abrindo http://localhost:4321
  start http://localhost:4321
)
echo.
echo Previa no ar. Para parar, feche a janela "Previa Rio Mundo".
echo Gostou? Rode publicar.bat. Mudou de ideia? Apague o rascunho de
echo "Para publicar" E a copia em src\content\colunas.
pause
exit /b 0

REM Copia arquivos de UMA extensao sem mover nem apagar a origem.
:Copiar
set "O=%~1"
set "DT=%~2"
if exist "!O!\%~3" (
  for %%F in ("!O!\%~3") do (
    copy /y "%%~fF" "!DT!\%%~nxF" >nul
    set /a COPIADOS+=1
    echo PREVIA - %%~nxF
  )
)
exit /b 0
