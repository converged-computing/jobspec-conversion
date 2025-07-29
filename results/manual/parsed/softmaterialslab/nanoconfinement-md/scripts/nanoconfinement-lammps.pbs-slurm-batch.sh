#!/bin/bash
#SBATCH --job-name=IONS_LAMMPS
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=general
#SBATCH --constraint=ntasks-per-node=16

export OMP_NUM_THREADS='16'

module swap PrgEnv-intel PrgEnv-gnu
module load boost/gnu
module load gsl
module load lammps/gnu/7Aug19
cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=16
time srun -n 1 -d 16 lmp_mpi < in.lammps
