#!/bin/bash
#FLUX: --job-name=chocolate-poo-0437
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=21600
#FLUX: --priority=16

/usr/bin/nvidia-smi
/usr/bin/scontrol show job -d "$SLURM_JOB_ID"
module use /opt/insy/modulefiles
module load cuda/11.1 cudnn/11.1-8.0.5.39
source /home/nfs/arkhan/venv0/bin/activate
srun python xlntcr_ep0.py
