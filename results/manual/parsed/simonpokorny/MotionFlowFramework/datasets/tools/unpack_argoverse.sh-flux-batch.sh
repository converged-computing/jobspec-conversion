#!/bin/bash
#FLUX: --job-name=expressive-leopard-1492
#FLUX: --queue=amdfast
#FLUX: -t=14400
#FLUX: --urgency=16

ml torchsparse
cd $HOME
python -u my_datasets/argoverse/argoverse2.py $SLURM_ARRAY_TASK_ID
