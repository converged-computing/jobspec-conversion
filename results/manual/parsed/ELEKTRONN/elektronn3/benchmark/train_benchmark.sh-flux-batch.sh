#!/bin/bash
#FLUX: --job-name=E3_TRAIN_GPU_TEST
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load anaconda/3/2020.02
conda activate e3
srun python3 ./train_benchmark.py --jit=disabled
srun python3 ./train_benchmark.py --jit=disabled --amp
srun python3 ./train_benchmark.py --jit=disabled --dp
srun python3 ./train_benchmark.py --jit=disabled --dp --amp
