#!/bin/bash
#FLUX: --job-name=dwt
#FLUX: -t=180
#FLUX: --urgency=16

FILE=dwt
gcc -fno-tree-vectorize -Wall ${FILE}.c  -march=znver1 -o ${FILE}.out  -lm 
./${FILE}.out
rm ./${FILE}.out
