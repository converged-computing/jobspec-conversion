#!/bin/bash
#FLUX: --job-name=crusty-banana-5305
#FLUX: -c=2
#FLUX: --queue=amdfast
#FLUX: -t=14400
#FLUX: --urgency=16

ml torchsparse
cd $HOME
python -u my_datasets/waymo/waymo.py $SLURM_ARRAY_TASK_ID
