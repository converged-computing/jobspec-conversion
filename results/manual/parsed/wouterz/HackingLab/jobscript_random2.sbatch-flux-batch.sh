#!/bin/bash
#FLUX: --job-name=carnivorous-itch-2102
#FLUX: --queue=stud-ewi
#FLUX: -t=3600
#FLUX: --urgency=16

module use /opt/insy/modulefiles
module load cuda/10.1 cudnn/10.1-7.6.0.64
srun python3 ./random_adv_script.py
