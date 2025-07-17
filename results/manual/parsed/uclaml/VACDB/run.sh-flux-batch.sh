#!/bin/bash
#FLUX: --job-name=v3
#FLUX: --queue=main
#FLUX: -t=600
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
source ~/.bashrc
mamba activate nrm
srun python3 main.py $SLURM_ARRAY_TASK_ID
