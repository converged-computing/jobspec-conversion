#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=9500
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=./

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPI_NUM_RANKS='$SLURM_NTASKS_PER_NODE'
export OMP_PLACES='cores  ## with enabled hyperthreading this line needs to be commented out'

source ~/sources/asyncmd_dev_modules.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPI_NUM_RANKS=$SLURM_NTASKS_PER_NODE
export OMP_PLACES=cores  ## with enabled hyperthreading this line needs to be commented out
srun {mdrun_cmd}
