#!/bin/bash
#SBATCH --job-name=BULKBOX
#SBATCH --account=SLC103
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=compute

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
source ~/env/lammps.sh
cycles=2
threads_per_partition=1
module load fftw openmpi
srun $LAMMPS_EXE -in start.lmp
