#!/bin/bash
#FLUX: --job-name=uji
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.5
module load cuda/9.0
module load cudnn/7.0
source ~/keras-env/bin/activate
cd /home/qfournie/dimensionality_reduction
python3 main.py -d uji -t dimension -c knn --start_dim $SLURM_ARRAY_TASK_ID --n_dim 1
