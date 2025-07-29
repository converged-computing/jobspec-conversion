#!/bin/bash
#SBATCH --job-name=LSTM_A100_DATA
#SBATCH --output=%x.%j.o
#SBATCH --error=%x.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=toreador
#SBATCH --constraint=ntasks-per-node=16

module load gcc cuda cudnn
. $HOME/conda/etc/profile.d/conda.sh
conda activate tensorflow
./clean # remove any results from prior runs and create a results folder
./launch
