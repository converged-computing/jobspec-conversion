#!/bin/bash
#FLUX: --job-name=carnivorous-bike-2723
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load gcc/5.4.0 python-env/intelpython3.6-2018.3
module load openmpi/2.1.2 cuda/9.0 cudnn/7.4.1-cuda9
srun python gen_motion_data.py
