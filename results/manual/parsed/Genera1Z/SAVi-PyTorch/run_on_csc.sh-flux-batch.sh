#!/bin/bash
#FLUX: --job-name=savi
#FLUX: -c=8
#FLUX: --queue=gpusmall
#FLUX: -t=129600
#FLUX: --priority=16

module load pytorch tensorflow vim
pip install -r requirements.txt
cp -r /scratch/project_2008396/Datasets/movi_a/* $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
srun python main.py --data_dir $LOCAL_SCRATCH
