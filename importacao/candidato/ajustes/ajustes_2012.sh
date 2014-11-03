#!/bin/bash

# há três ocorrências espúrias do \ ("escape character")
sed -i 's,\\\";,\";,g' ./temp/cand_2012.txt
