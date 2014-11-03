#!/bin/bash

echo "Ano $1:"

echo "- Descompactando arquivos do ano de $1..."
unzip -q ./zips/consulta_cand_$1.zip -d ./temp
rm ./temp/LEIAME.pdf

echo "- Reunindo arquivos de dados do ano de $1..."
files=./temp/consulta_cand_$1_*.txt
cat $files > ./temp/cand_$1.txt
cat $files > ./temp/cand_$1.txt.backup
rm ./temp/consulta_cand_$1_*.txt

echo "- Eliminando espaços, aspas inúteis e quebras de linha do Windows..."
./scripts/elimina_aspas_espacos.sh ./temp/cand_$1.txt

echo "- Realizando ajustes para o ano de $1..."
./ajustes/ajustes_$1.sh

echo "- Criando tabela de candidatos para o ano de $1..."
source ./conf/mysql.cfg
mysql --user=$username --password=$password $database -e "call eleicoes.cria_tabela_candidato($1);"

echo "- Importando dados dos candidatos do ano de $1..."
cp ./sql/importa_candidatos.sql ./temp/importa_candidatos_$1.sql
sed -i "s,WWWfolder_temporario,$folder_temporario,g" ./temp/importa_candidatos_$1.sql
sed -i "s,WWWano,$1,g" ./temp/importa_candidatos_$1.sql
mysql --user=$username --password=$password $database < ./temp/importa_candidatos_$1.sql > ./logs/cand_$1.log
rm ./temp/importa_candidatos_$1.sql
