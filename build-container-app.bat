@echo off
REM Verifica os parâmetros fornecidos
if "%1"=="" (
    echo Caminho da imagem não fornecida
    exit /b 1
)

if "%2"=="" (
    echo Versão da imagem não fornecida
    exit /b 1
)


REM Chama o bat de criação de DIST
call build-dist-app.bat

REM Define o parâmetro como uma variável
set caminho_imagem_docker=%1
set tag=%2

REM Executa o comando docker build
echo Executando: docker build -t arthurandraadee/server-golang:%tag% .
docker build -t arthurandraadee/server-golang:%tag% %caminho_imagem_docker%

REM Verifica se o build foi bem sucedido
if errorlevel 1 (
    echo Erro durante a execucao do docker build.
    exit /b 1
)

REM Executa o comando docker run
echo Executando: docker run -d -p 80:8080 --name server-golang-testing arthurandraadee/server-golang:%tag%
docker run -d -p 80:8080 --name server-golang-testing arthurandraadee/server-golang:%tag%

REM Verifica se o run foi bem sucedido
if errorlevel 1 (
    echo Erro durante a execucao do docker run.
    exit /b 1
)

REM Publica imagem 
echo Publicando imagem no DockerHub
docker push arthurandraadee/server-golang:%tag%