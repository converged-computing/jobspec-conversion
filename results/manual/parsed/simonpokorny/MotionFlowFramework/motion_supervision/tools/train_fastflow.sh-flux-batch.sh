#!/bin/bash
#FLUX: --job-name=psycho-latke-9106
#FLUX: -c=4
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

ml torchsparse
cd $HOME/motion_supervision
python -u train.py $SLURM_ARRAY_TASK_ID
