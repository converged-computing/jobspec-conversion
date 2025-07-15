#!/bin/bash
#FLUX: --job-name=ornery-lettuce-6570
#FLUX: --queue=amdfast
#FLUX: -t=14400
#FLUX: --priority=16

ml torchsparse
cd $HOME
python -u my_datasets/argoverse/argoverse2.py $SLURM_ARRAY_TASK_ID
