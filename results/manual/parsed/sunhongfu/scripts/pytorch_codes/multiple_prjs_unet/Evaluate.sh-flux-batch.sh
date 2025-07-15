#!/bin/bash
#FLUX: --job-name=eval_multiple_prjs_unet_alldirs
#FLUX: --queue=gpu
#FLUX: --priority=16

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
python --version
srun python -u  eval_multiple_D_unet.py
