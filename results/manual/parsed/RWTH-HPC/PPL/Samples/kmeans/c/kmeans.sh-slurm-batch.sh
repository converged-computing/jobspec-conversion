#!/bin/bash
#SBATCH --job-name=KMEANS
#SBATCH --output=output.kmeans.second.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --partition=c18g

module switch intel gcc/9
module load cuda/112
echo; export; echo;  nvidia-smi; echo
cd ~/benchmark/c/kmeans
nvcc -Xcompiler -fopenmp -o kmeans.out kmeans.cu
for i in {1..30}
do
   ./kmeans.out
done
