#!/bin/bash
#SBATCH --output=openacc.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1

cp 500.bmp *.c $PFSDIR/.
cd $PFSDIR
module load pgi
pgcc -ta=nvidia:cc20 -acc openacc.c -o openacc -lm
echo size 500 
./openacc 10 500
