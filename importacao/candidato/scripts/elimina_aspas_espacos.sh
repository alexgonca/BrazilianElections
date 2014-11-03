#!/bin/bash

#eliminar mais de um espaço em branco adjacente
sed -i 's/    / /g' $1
sed -i 's/   / /g' $1
sed -i 's/  / /g' $1

# "iii";"  joca";"jjj" >> "iii";"joca";"jjj"
sed -i 's/;\" /;\"/g' $1
sed -i 's/;\" /;\"/g' $1
sed -i 's/;\" /;\"/g' $1

# "iii";"joca  ";"jjj" >> "iii";"joca";"jjj"
sed -i 's/ \";/\";/g' $1
sed -i 's/ \";/\";/g' $1
sed -i 's/ \";/\";/g' $1

# "iii";"";"jjj" >> "iii"zzzyyy"jjj" (para destrocar no fim)
sed -i 's/;\"\";/;zzzyyy;/g' $1
sed -i 's/;\"\";/;zzzyyy;/g' $1
sed -i 's/;\"\";/;zzzyyy;/g' $1

# converte para o padrão de quebra de linha do linux
perl -pi -e 's/\r\n/\n/' $1

# campo vazio próximo à quebra de linha (para destrocar no fim)
sed -i 's/;\"\"$/;sssppp/g' $1

# "iii";"-1";"jjj" >> "iii"gggwww"jjj" (para destrocar no fim)
sed -i 's/;\"-/;gggwww/g' $1

# "iii";"1-";"jjj" >> "iii"gggwww"jjj" (para destrocar no fim)
sed -i 's/-\";/qqqyyy;/g' $1

# "iii";""joca";"jjj" >> "iii";"\"joca";"jjj"
sed -i 's/;\"\"/;\"\\\"/g' $1

# "iii";"joca"";"jjj" >> "iii";"joca\"";"jjj"
sed -i 's/\"\";/\\\"\";/g' $1

# "iii";"joca" da silva";"jjj" >> "iii";"joca\" da silva";"jjj"
sed -i 's/\" /\\\" /g' $1

# "iii";"joca "da silva";"jjj" >> "iii";"joca \"da silva";"jjj"
sed -i 's/ \"/ \\\"/g' $1

# "iii";"joca"-da silva";"jjj" >> "iii";"joca\"-da silva";"jjj"
sed -i 's/\"-/\\\"-/g' $1

# "iii";"joca-"da silva";"jjj" >> "iii";"joca-\"da silva";"jjj"
sed -i 's/-\"/-\\\"/g' $1

# destroca
sed -i 's/;zzzyyy;/;\"\";/g' $1
sed -i 's/;zzzyyy;/;\"\";/g' $1
sed -i 's/;zzzyyy;/;\"\";/g' $1
sed -i 's/;gggwww/;\"-/g' $1
sed -i 's/qqqyyy;/-\";/g' $1
sed -i 's/;sssppp/;\"\"/g' $1

