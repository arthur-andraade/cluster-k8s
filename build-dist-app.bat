@echo off
REM Definindo os diretórios de origem e destino
set source=C:\DEV\Projetos\Kubernetes\cluster-k8s\app
set destination=C:\DEV\Projetos\Kubernetes\cluster-k8s\containers\server\dist

REM Exibindo mensagem de início do processo de cópia
echo Copiando arquivos da pasta %source% para %destination%

REM Verificando se o diretório de destino existe, se não, cria-o
if not exist %destination% (
    mkdir %destination%
)

REM Copiando os arquivos
xcopy %source%\* %destination%\* /E /H /C /I

REM Exibindo mensagem de conclusão
echo Arquivos copiados para DIST com sucesso!

