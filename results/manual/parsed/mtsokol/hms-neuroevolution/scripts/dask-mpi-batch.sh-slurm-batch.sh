#!/bin/bash
#SBATCH --job-name=hms-neuro-job
#SBATCH --account=<GRANT_ID>
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=55G
#SBATCH --time=01:00:00
#SBATCH --partition=plgrid-short
#SBATCH --constraint=ntasks-per-node=24

export NOISE_PATH='/net/archive/groups/plgghmsneuro/noise.npy'

export NOISE_PATH=/net/archive/groups/plgghmsneuro/noise.npy
module load plgrid/libs/python-mpi4py/3.0.1-python-3.6
mpirun -np 240 python3 -m implementation.experiments.hms_atari_sea -e 60
