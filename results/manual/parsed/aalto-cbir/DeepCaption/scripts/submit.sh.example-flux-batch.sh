#!/bin/bash
#FLUX --job-name=muffled-leopard-0456
#FLUX --queue=gpu
#FLUX -t=120
#FLUX --urgency=16

module purge
module load python-env/intelpython3.6-2018.3
module load gcc/5.4.0 cuda/9.0 cudnn/7.1-cuda9
srun $*
