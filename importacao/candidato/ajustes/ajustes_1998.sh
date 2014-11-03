#!/bin/bash

# o campo COMPOSICAO_LEGENDA aparece duplicado (e com o valor "#NE#") em todos os registros.
sed -i 's/;"#NE#";"#NE#";/;"#NE#";/g' ./temp/cand_1998.txt
