#!/bin/bash

# correção de uma data levemente inconsistente.
sed -i 's,;\"2801 966\";,;\"28011966\";,g' ./temp/cand_2004.txt
