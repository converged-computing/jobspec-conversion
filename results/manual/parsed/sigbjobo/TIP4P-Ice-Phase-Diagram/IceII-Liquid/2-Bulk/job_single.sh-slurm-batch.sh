#!/bin/bash
#SBATCH --job-name=2-Bulk
#SBATCH --account=SLC103
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module load fftw openmpi
source ~/env/lammps.sh
cycles=2
threads_per_partition=1
srun $LAMMPS_EXE  -in start.lmp
date
