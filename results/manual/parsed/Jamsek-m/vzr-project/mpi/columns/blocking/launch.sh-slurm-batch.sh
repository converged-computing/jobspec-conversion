#!/bin/bash
#SBATCH --job-name=heat
#SBATCH --output=out/log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100M
#SBATCH --constraint=ntasks-per-node=32

module load mpi/openmpi-x86_64
mpirun -np $SLURM_NTASKS --map-by ppr:32:node --mca coll ^tuned ./main.mpi 8096 8096
