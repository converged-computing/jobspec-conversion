#!/bin/bash
#SBATCH --job-name=plumed
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=jobs
#SBATCH --constraint=ntasks-per-node=2

module load intel
module load intel-mkl
module load intel-mpi
module load lammps
LAMMPS=lmp_mpi
cd example_natasha
srun --time=24:00:00 --hint=nomultithread --exclusive -n ${SLURM_NTASKS} ${LAMMPS} -i in.lmp > log.lammps
