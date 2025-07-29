#!/bin/bash
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:02:00
#SBATCH --constraint=ntasks-per-node=16,ntasks-per-socket=8

module load anaconda
module load cudatoolkit/7.5 cudann
module load openmpi
echo "Removing old model checkpoints."
rm /tigress/jk7/data/model_checkpoints/*
echo "Running distributed learning"
mpirun -npernode 4 python mpi_learn.py
