#!/bin/bash
#SBATCH --job-name=jobs
#SBATCH --account=wag
#SBATCH --output=gromacs%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00

cd $SLURM_SUBMIT_DIR
~/soft/lammps/lammps-3Mar20/src/lmp_mpi -in in.lmp > log
