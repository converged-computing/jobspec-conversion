#!/bin/bash
#SBATCH --job-name=dwt
#SBATCH --output=test2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00
#SBATCH --constraint=ntasks-per-node=1,amd

FILE=dwt
gcc -fno-tree-vectorize -Wall ${FILE}.c  -march=znver1 -o ${FILE}.out  -lm 
./${FILE}.out
rm ./${FILE}.out
