#!/bin/bash
#SBATCH --job-name=basic_algo
#SBATCH --output=./basic_algo.out
#SBATCH --error=./basic_algo.err
#SBATCH --mail-user=yue.zhang@lipn.univ-paris13.fr
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
for file in ./MOBKP/set3/*; do
    echo "$file"
    julia vOptMomkp.jl "$file"
done
