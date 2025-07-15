#!/bin/bash
#FLUX: --job-name=gassy-onion-8335
#FLUX: --queue=stud-ewi
#FLUX: -t=3600
#FLUX: --priority=16

module use /opt/insy/modulefiles
module load cuda/10.1 cudnn/10.1-7.6.0.64
srun python3 ./random_adv_script.py
