#!/bin/bash
#FLUX: --job-name=ptg-qm9-C
#FLUX: --queue=rondror
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc/8.1.0
module load cuda/10.0
source /home/users/mvoegele/miniconda3/etc/profile.d/conda.sh
conda activate /oak/stanford/groups/rondror/users/mvoegele/envs/geometric
python train_qm9.py --target 18 --prefix qm9-C --load
