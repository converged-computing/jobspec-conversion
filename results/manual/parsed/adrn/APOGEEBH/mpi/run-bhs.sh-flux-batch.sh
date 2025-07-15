#!/bin/bash
#FLUX: --job-name=lovely-cat-5736
#FLUX: --priority=16

cd /tigress/adrianp/projects/apogeebh/scripts/
module load openmpi/gcc/1.10.2/64
source activate twoface
date
srun python run_bh.py -v -c ../config/bh.yml  --mpi --data-path=../data/candidates/ --ext=ecsv
date
