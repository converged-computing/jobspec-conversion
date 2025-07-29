#!/bin/bash
#SBATCH --job-name=all2all
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2g
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=1

module load openmpi
module load python/3.7.2
source venv/bin/activate
mpirun -bind-to none ./sendrecv.py 
