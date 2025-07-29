#!/bin/bash
#SBATCH --job-name=lammps_rerun
#SBATCH --account=z19
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=short

export OMP_NUM_THREADS='1'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load lammps/15Dec2023
export OMP_NUM_THREADS=1
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
srun --distribution=block:block --hint=nomultithread lmp -in rerun.in -partition 10x1
