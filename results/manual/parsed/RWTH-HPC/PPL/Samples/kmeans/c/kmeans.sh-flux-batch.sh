#!/bin/bash
#FLUX: --job-name=KMEANS
#FLUX: -t=14400
#FLUX: --urgency=16

module switch intel gcc/9
module load cuda/112
echo; export; echo;  nvidia-smi; echo
cd ~/benchmark/c/kmeans
nvcc -Xcompiler -fopenmp -o kmeans.out kmeans.cu
for i in {1..30}
do
   ./kmeans.out
done
