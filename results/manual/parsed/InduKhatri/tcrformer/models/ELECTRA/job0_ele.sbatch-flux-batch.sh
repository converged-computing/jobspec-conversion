#!/bin/bash
#FLUX: --job-name=ornery-parrot-3919
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=10800
#FLUX: --urgency=16

/usr/bin/nvidia-smi -L
/usr/bin/scontrol show job -d "$SLURM_JOB_ID"
module use /opt/insy/modulefiles
module load cuda/11.5 cudnn/11.5-8.3.0.98
source /home/nfs/arkhan/venv0/bin/activate
srun python eletcr_ep0.py
