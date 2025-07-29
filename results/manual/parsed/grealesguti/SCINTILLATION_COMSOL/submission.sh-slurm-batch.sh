#!/bin/bash
#SBATCH --job-name=matlab_demo
#SBATCH --account=innovation
#SBATCH --output=OUT/hello_world_mpi.%j.out
#SBATCH --error=ERR/hello_world_mpi.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=04:00:00

srun scomsoltest.sh
