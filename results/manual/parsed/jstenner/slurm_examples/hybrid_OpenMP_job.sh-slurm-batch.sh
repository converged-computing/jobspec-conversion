#!/bin/bash
#SBATCH --job-name=LAMMPS
#SBATCH --output=LAMMPS_%j.out
#SBATCH --mail-user=<email_address>
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2000mb
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=2,ntasks-per-socket=1

export OMP_NUM_THREADS='8'

date
hostname
module load intel/2018 openmpi
export OMP_NUM_THREADS=8
srun --mpi=pmix_v2 /path/to/app/lmp_gator2 < in.Cu.v.24nm.eq_xrd
