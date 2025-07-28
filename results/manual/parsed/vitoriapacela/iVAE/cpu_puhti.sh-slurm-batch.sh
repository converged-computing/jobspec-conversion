#!/bin/bash
#FLUX: --job-name=iVAE
#FLUX: -c=10
#FLUX: --queue=small
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load pytorch/1.4
srun python3 main.py --config binary-6-2-fast_ica.yaml --n-sims 3 --m 2.0 --s 0
