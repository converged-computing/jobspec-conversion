#!/bin/bash
#FLUX: --job-name=iVAE
#FLUX: -c=10
#FLUX: --queue=longrun
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load pytorch/1.4
srun python3 main.py --config test-full-ivae-u.yaml --n-sims 1 --m 0.5 --s 0
