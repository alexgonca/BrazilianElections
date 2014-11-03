#!/bin/bash

# a descrição da coligação aparece duas vezes nos candidatos a presidente.
sed -i 's,;\"#NULO#\";\"#NULO#\";\"#NULO#\";\"#NULO#\";,;\"#NULO#\";\"#NULO#\";\"#NULO#\";,g' ./temp/cand_1994.txt
sed -i 's,;\"PT/PSTU/PPS/PSB/PV\";\"PT/PSTU/PPS/PSB/PV\";,;\"PT/PSTU/PPS/PSB/PV\";,g' ./temp/cand_1994.txt
sed -i 's,;\"PMDB/PSD\";\"PMDB/PSD\";,;\"PMDB/PSD\";,g' ./temp/cand_1994.txt
sed -i 's,;\"PTB/PFL/PSDB\";\"PTB/PFL/PSDB\";,;\"PTB/PFL/PSDB\";,g' ./temp/cand_1994.txt

# há um candidato com um título de eleitor de 13 dígitos (o correto são 12 dígitos).
sed -i 's,;\"1143274800132\";,;\"\";,g' ./temp/cand_1994.txt
