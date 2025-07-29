#!/bin/bash
#SBATCH --job-name=apogeebh
#SBATCH --output=apogeebh.o%j
#SBATCH --error=apogeebh.e%j
#SBATCH --mail-user=adrn@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=224
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

cd /tigress/adrianp/projects/apogeebh/scripts/
module load openmpi/gcc/1.10.2/64
source activate twoface
date
srun python run_bh.py -v -c ../config/bh.yml  --mpi --data-path=../data/candidates/ --ext=ecsv
date
