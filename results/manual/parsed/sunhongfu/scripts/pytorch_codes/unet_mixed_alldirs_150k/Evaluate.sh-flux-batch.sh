#!/bin/bash
#FLUX: --job-name=eval_unet_mixed_alldirs_150k
#FLUX: -c=3
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
python --version
srun python -u eval_unet_mixed.py
