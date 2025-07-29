#!/bin/bash
#FLUX: --job-name=federaser
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda/10.0.130
module load anaconda/3.6
source activate federaser
srun python ../Fed_Unlearn_main_6.py
