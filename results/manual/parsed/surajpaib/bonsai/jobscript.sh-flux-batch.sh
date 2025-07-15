#!/bin/bash
#FLUX: --job-name=MRP_dke
#FLUX: -c=48
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module switch intel gcc
module load python/3.6.8
module load cuda/100
module load cudnn/7.4
pip install --user -r requirements.txt
python application/grid_search.py --epochs 50
