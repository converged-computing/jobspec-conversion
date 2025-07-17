#!/bin/bash
#FLUX: --job-name=chocolate-punk-9743
#FLUX: -c=6
#FLUX: --queue=amdlong
#FLUX: -t=259200
#FLUX: --urgency=16

ml torchsparse
cd $HOME
python -u motion_supervision/preprocess_data.py $SLURM_ARRAY_TASK_ID
