#!/bin/bash
#SBATCH --job-name=planet
#SBATCH --output=planet.o%j
#SBATCH --error=planet.e%j
#SBATCH --mail-user=adrn@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=224
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

cd /tigress/adrianp/projects/dailyplanet/scripts/
module load openmpi/gcc/1.10.2/64
source activate twoface
date
srun python run_planetz.py -v -c ../config/planetz.yml --mpi --data-path=../data/keck_vels/ --ext=vels
date
