#!/bin/bash
#FLUX: --job-name=lovely-lizard-9900
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load gcc/8.3.0
module load python/3.7.6
module load nvidia-hpc-sdk/21.7
source env/bin/activate
python -m signjoey train configs/sign.yaml
deactivate
