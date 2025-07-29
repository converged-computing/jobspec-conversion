#!/bin/bash
#SBATCH --job-name=mnist-lenet5
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=knl

module load tensorflow/intel-1.13.1-py36
script=mnist.py
path=hpo/mnist-lenet5/source
cd $path && python $script
