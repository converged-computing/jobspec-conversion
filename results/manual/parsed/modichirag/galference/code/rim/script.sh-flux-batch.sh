#!/bin/bash
#FLUX: --job-name=creamy-butter-4422
#FLUX: --priority=16

module purge && module load  esslurm gcc/7.3.0 python3 cuda/10.1.243
pip install --user tensorflow
time srun python -u cosmic_rim_multi_poisson.py --nc 64 --bs 200 --nbody False --lpt_order 2 --nsims 500 --batch_size 2 --plambda 0.1
