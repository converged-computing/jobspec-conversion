#!/bin/bash
#FLUX: --job-name=iVAE
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load pytorch/1.4
srun python3 main.py --config binary-5-adam-Copy7.yaml --n-sims 3 --m 2.0 --s 33 --fix_prior_mean
