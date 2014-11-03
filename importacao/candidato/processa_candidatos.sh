#!/bin/bash

echo "Cria funções no banco de dados."
# obtem dados para conectar-se ao banco de dados MySql.
source ./conf/mysql.cfg
# cria função e procedimento auxiliares para importação dos dados.
mysql --user=$username --password=$password $database < ./sql/cria_funcao_corrige_data.sql
mysql --user=$username --password=$password $database < ./sql/cria_procedimento_tabela_candidato.sql

./scripts/processa_ano.sh 1994
./scripts/processa_ano.sh 1996
./scripts/processa_ano.sh 1998
./scripts/processa_ano.sh 2000
./scripts/processa_ano.sh 2002
./scripts/processa_ano.sh 2004
./scripts/processa_ano.sh 2006
./scripts/processa_ano.sh 2008
./scripts/processa_ano.sh 2010
./scripts/processa_ano.sh 2012

echo "Processo finalizado. Verifique o diretório de logs."
