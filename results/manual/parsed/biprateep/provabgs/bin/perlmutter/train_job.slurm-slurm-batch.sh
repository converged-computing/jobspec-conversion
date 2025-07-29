#!/bin/bash
#SBATCH --account=desi_g
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --gpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=1

export SLURM_CPU_BIND='cores'

export SLURM_CPU_BIND="cores"
module load tensorflow/2.6.0
srun python /global/homes/b/bid13/provabgs/bin/emulator.py nmf 100 0 50 8 256 2048
