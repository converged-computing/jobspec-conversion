#!/bin/bash
#SBATCH --job-name=Interface
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=300M
#SBATCH --time=1-00:00:00
#SBATCH --constraint=haswell|broadwell|skylake|cascade

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load intel-mpi intel
LAMMPS_HOME=/home/ppiaggi/Programs/Lammps/lammps-git-cpu/build4
LAMMPS_EXE=${LAMMPS_HOME}/lmp_della
srun $LAMMPS_EXE -in start.lmp
date
