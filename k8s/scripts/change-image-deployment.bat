@echo off

if "%1"=="" (
    echo Versão da imagem nova não fornecida
    exit /b 1
)

if "%2"=="" (
    echo Versão da imagem antiga não fornecida
    exit /b 1
)

if "%3"=="" (
    echo Ambiente do artefato Deployment não fornecida
    exit /b 1
)

REM Arquivo YAML do deployment
SET DEPLOYMENT_FILE=../environment/%3/deployment.yaml

REM Imagem antiga
SET OLD_IMAGE=arthurandraadee/server-golang:%2

REM Nova imagem
SET NEW_IMAGE=arthurandraadee/server-golang:%1

REM Atualiza a imagem no arquivo YAML
powershell -Command "(Get-Content %DEPLOYMENT_FILE%) -replace '%OLD_IMAGE%', '%NEW_IMAGE%' | Set-Content %DEPLOYMENT_FILE%"

REM Verifica se a atualização foi bem-sucedida
if %ERRORLEVEL% EQU 0 (
    echo Deployment atualizado com sucesso para a imagem %NEW_IMAGE%
) else (
    echo Falha ao atualizar o Deployment
)
