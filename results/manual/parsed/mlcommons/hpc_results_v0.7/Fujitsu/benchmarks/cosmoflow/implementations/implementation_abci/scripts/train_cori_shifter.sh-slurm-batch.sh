#!/bin/bash
#SBATCH --job-name=train-cori
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=knl

singularity
exec
docker:sfarrell/cosmoflow-cpu-mpich:latest
set -x
srun -l -u shifter python train.py -d $@
