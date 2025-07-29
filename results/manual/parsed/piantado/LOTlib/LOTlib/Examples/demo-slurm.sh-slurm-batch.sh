#!/bin/bash
#SBATCH --job-name=LOTlibSearch
#SBATCH --account=colala
#SBATCH --output=output/out_%j
#SBATCH --error=output/err_%j
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=4-04:15:00
#SBATCH --qos=colala
#SBATCH --constraint=ntasks-per-node=24

module load numpy
module load python/2.7.6
module load openmpi/1.6.5/b1
srun python Search.py --model=Number --data=300 --steps=10000
exit
