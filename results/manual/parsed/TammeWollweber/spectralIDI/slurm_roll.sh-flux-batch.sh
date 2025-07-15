#!/bin/bash
#FLUX: --job-name=buttery-gato-5656
#FLUX: -c=2
#FLUX: --queue=gpu-ayyer
#FLUX: -t=129600
#FLUX: --priority=16

srun python roll_mem.py 
