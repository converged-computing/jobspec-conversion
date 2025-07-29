#!/bin/bash
#SBATCH --job-name=mpi_dot
#SBATCH --output=mpi_dot.out
#SBATCH --error=mpi_dot.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:00:10

PRO=mpi_dot
module load gcc/9.3.0-fasrc01 openmpi/4.0.5-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x | sort -k7 -n > ${PRO}.dat
