#!/bin/bash
#FLUX: --job-name=run_221
#FLUX: -c=4
#FLUX: -t=36000
#FLUX: --urgency=16

cd /mnt/home/kumarab6/project/DEVIANT/code ### change to the directory where your code is located
conda activate DEVIANT ### Activate virtual environment
srun /mnt/home/kumarab6/anaconda3/envs/DEVIANT/bin/python -u tools/train_val.py --config=experiments/run_221.yaml ### Run python code
scontrol show job $SLURM_JOB_ID ### write job information to output file
