#!/bin/bash
#SBATCH --job-name=si-1b-1400K
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load anaconda3/2021.5
conda activate deepmd-2.1.3
LAMMPS_EXE=lmp
srun $LAMMPS_EXE -in start.lmp
date
