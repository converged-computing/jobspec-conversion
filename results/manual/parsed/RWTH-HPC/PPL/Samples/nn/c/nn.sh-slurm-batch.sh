#!/bin/bash
#SBATCH --job-name=NN
#SBATCH --output=output.nn.second.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:2
#SBATCH --mem=20G
#SBATCH --time=04:00:00

ml CUDA
echo; export; echo;  nvidia-smi; echo
nvcc -Xcompiler -fopenmp -o nn.out neural_network.cu -lcurand
for i in {1..40}
do
   ./nn.out
done
