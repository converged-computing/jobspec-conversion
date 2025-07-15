#!/bin/bash
#FLUX: --job-name=moolicious-arm-1866
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load anaconda/3/2020.02
conda activate e3
srun python3 ./train_benchmark.py --jit=disabled
srun python3 ./train_benchmark.py --jit=disabled --amp
srun python3 ./train_benchmark.py --jit=disabled --dp
srun python3 ./train_benchmark.py --jit=disabled --dp --amp
