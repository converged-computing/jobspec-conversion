#!/bin/bash
#FLUX: --job-name=iVAE
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module purge
module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.4
srun python3 main.py --config binary-6-2-fast_ica.yaml --n-sims 3 --m 2.0 --s "$@" > "$1"_b_6_2.log
