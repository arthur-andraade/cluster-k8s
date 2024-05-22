@echo off

if "%1"=="" (
    echo Ambiente não fornecido
    exit /b 1
)

if "%2"=="" (
    echo Artefato não fornecido
    exit /b 1
)

REM Aplicar deployment
kubectl apply -f ../environment/%1/%2.yaml