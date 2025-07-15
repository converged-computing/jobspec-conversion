#!/bin/bash
#FLUX: --job-name=sticky-hobbit-7294
#FLUX: -c=2
#FLUX: --queue=gpu-ayyer
#FLUX: -t=129600
#FLUX: --urgency=16

srun python roll_mem.py 
