#!/bin/bash 
#SBATCH -J EQ_POCG_12
#SBATCH -o out%j.amarel.log
#SBATCH --export=ALL
#SBATCH --partition=cmain
#SBATCH -N 3 -n 96
##SBATCH -N 1 -n 32
#SBATCH --mem=6000
#SBATCH -t 00:30:00       # max time
#SBATCH --output=starting.out     # STDOUT output file
#SBATCH --requeue
module purge
module load gcc cuda mvapich2/2.2
NAMD="/projects/jdb252_1/tj227/bin/namd2-2.13-gcc-mvapich2"
SRUN="srun --mpi=pmi2"
$SRUN $NAMD starting.POCG_12.namd > starting.POCG_12.log
