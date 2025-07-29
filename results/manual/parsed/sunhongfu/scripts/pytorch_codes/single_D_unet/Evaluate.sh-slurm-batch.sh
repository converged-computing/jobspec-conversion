#!/bin/bash
#FLUX: --job-name=HS_test_single_D
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
srun python -u  /scratch/itee/uqhsun8/CommQSM/pytorch_codes/single_D_unet/eval_single_D_unet.py
