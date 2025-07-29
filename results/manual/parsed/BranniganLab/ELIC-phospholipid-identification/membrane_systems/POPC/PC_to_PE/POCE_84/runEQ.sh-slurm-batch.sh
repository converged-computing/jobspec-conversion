#!/bin/bash
#SBATCH --job-name=EQ_POCE_84
#SBATCH --output=starting.out
#SBATCH --nodes=3
#SBATCH --ntasks=96
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6000
#SBATCH --time=00:30:00
#SBATCH --partition=cmain

module purge
module load gcc cuda mvapich2/2.2
NAMD="/projects/jdb252_1/tj227/bin/namd2-2.13-gcc-mvapich2"
SRUN="srun --mpi=pmi2"
$SRUN $NAMD starting.POCE_84.namd > starting.POCE_84.log
