#!/bin/bash
#SBATCH --job-name=LAMMPS_Bench
#SBATCH --output=results_%j.out
#SBATCH --error=results_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=longjobs

export OMP_NUM_THREADS='1'
export WDIR='<REPO_DIR>/bench'

export OMP_NUM_THREADS=1
module load lammps
export WDIR=<REPO_DIR>/bench
srun --mpi=pmi2 lammps -in $WDIR/in.lj
srun --mpi=pmi2 lammps -in $WDIR/in.chain
srun --mpi=pmi2 lammps -in $WDIR/in.eam
srun --mpi=pmi2 lammps -in $WDIR/in.chute
srun --mpi=pmi2 lammps -in $WDIR/in.rhodo
