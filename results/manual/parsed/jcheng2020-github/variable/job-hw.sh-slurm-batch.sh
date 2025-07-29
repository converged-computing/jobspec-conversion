#!/bin/bash
#SBATCH --account=eel6763
#SBATCH --output=outfile
#SBATCH --error=errfile
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500mb
#SBATCH --time=00:05:00
#SBATCH --qos=eel6763
#SBATCH --constraint=ntasks-per-node=1

srun --mpi=pmix_v3 ./adam.out 500000
