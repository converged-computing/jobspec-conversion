#!/bin/bash
#FLUX: --job-name=yang_2L30EPO_pytorch
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load anaconda/3.6
source activate /opt/ohpc/pub/apps/pytorch_1.10_openmpi
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
python --version
srun python -u Train_D_Unet_singleLoss_40EPO.py
