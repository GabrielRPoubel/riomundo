@echo off
REM Rio Mundo - publicar tudo com duplo clique.
REM Move o que esta em "Para publicar" para o lugar certo,
REM IGNORA arquivos repetidos sem alteracao, confere o build,
REM commita e envia ao GitHub. Se nada mudou, nao faz nada.
cd /d "%~dp0"

set "IN_TXT=Para publicar\Textos"
set "IN_IMG=Para publicar\Imagens"
set "IN_AUD=Para publicar\Audios"
set "OUT_TXT=src\content\colunas"
set "OUT_IMG=public\imagens"
set "OUT_AUD=public\audio"
set "NPM=C:\Program Files\nodejs\npm.cmd"

if not exist "%IN_TXT%" mkdir "%IN_TXT%"
if not exist "%IN_IMG%" mkdir "%IN_IMG%"
if not exist "%IN_AUD%" mkdir "%IN_AUD%"
if not exist "%OUT_TXT%" mkdir "%OUT_TXT%"
if not exist "%OUT_IMG%" mkdir "%OUT_IMG%"
if not exist "%OUT_AUD%" mkdir "%OUT_AUD%"

where git >nul 2>nul
if errorlevel 1 goto SEMGIT

setlocal EnableDelayedExpansion
set NOVOS=0
set IGUAIS=0

echo === Recolhendo arquivos de Para publicar ===
call :Sincronizar "%IN_TXT%" "%OUT_TXT%" "*.md"
call :Sincronizar "%IN_IMG%" "%OUT_IMG%" "*.png *.jpg *.jpeg *.webp *.gif *.avif *.svg"
call :Sincronizar "%IN_AUD%" "%OUT_AUD%" "*.mp3"
echo.
echo Novos/atualizados: !NOVOS! - Sem alteracao: !IGUAIS!

set SUJO=0
for /f "delims=" %%L in ('git status --porcelain 2^>nul') do set SUJO=1
if "!NOVOS!"=="0" if "!SUJO!"=="0" goto NADA

echo.
echo === 1 de 3 - Conferindo o site com build ===
if exist "node_modules\.astro\data-store.json" del /q "node_modules\.astro\data-store.json"
call "%NPM%" run build
if errorlevel 1 goto FALHOU_BUILD

echo.
echo === 2 de 3 - Registrando alteracoes ===
git add -A
git diff --cached --quiet
if errorlevel 1 goto COMMIT
echo Nenhuma alteracao para registrar.
goto PUSH

:COMMIT
for /f "delims=" %%D in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'"') do set QUANDO=%%D
git commit -m "Publicar site - !QUANDO! - !NOVOS! arquivo novo" >nul
echo Commit criado.
goto PUSH

:PUSH
echo.
echo === 3 de 3 - Enviando ao GitHub ===
git push origin main
if errorlevel 1 goto FALHOU_PUSH

git status --porcelain -- "%OUT_AUD%" | findstr . >nul
if not errorlevel 1 goto AVISO_MP3
goto FIM_OK

:AVISO_MP3
echo.
echo AVISO - MP3 novo em public\audio. O player ainda precisa ser ligado no site. Me avise.
goto FIM_OK

:FIM_OK
echo.
echo Pronto - site publicado.
pause
exit /b 0

:SEMGIT
echo ERRO - Git nao encontrado. Reinstale o Git e tente de novo.
pause
exit /b 1

:NADA
echo.
echo Nada para publicar - tudo ja esta no ar.
pause
exit /b 0

:FALHOU_BUILD
echo.
echo ERRO - O build falhou. NADA foi publicado. Veja o erro acima.
pause
exit /b 1

:FALHOU_PUSH
echo.
echo ERRO - Falhou o envio. As alteracoes ficaram salvas aqui. Rode de novo.
pause
exit /b 1

REM Move arquivos novos ou alterados e ignora os identicos.
:Sincronizar
set "O=%~1"
set "DT=%~2"
for %%M in (%~3) do (
  if exist "!O!\%%M" (
    for %%F in ("!O!\%%M") do (
      set "NOME=%%~nxF"
      if not exist "!DT!\!NOME!" (
        copy /y "%%~fF" "!DT!\!NOME!" >nul
        del "%%~fF"
        set /a NOVOS+=1
        echo NOVO - !NOME!
      ) else (
        fc /b "%%~fF" "!DT!\!NOME!" >nul
        if errorlevel 1 (
          copy /y "%%~fF" "!DT!\!NOME!" >nul
          del "%%~fF"
          set /a NOVOS+=1
          echo ATUALIZADO - !NOME!
        ) else (
          del "%%~fF"
          set /a IGUAIS+=1
          echo IGUAL - !NOME! - ignorado
        )
      )
    )
  )
)
exit /b 0
