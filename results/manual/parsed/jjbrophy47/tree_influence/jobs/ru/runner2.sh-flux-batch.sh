#!/bin/bash
#FLUX: --job-name=Resources
#FLUX: --priority=16

module load miniconda
conda activate jbrophy-20210713
tree_type=$1
method=$2
seed=$3
. jobs/config.sh
dataset=${datasets[${SLURM_ARRAY_TASK_ID}]}
python3 scripts/experiments/single_test/resources.py \
  --dataset $dataset \
  --method $method \
  --tree_type $tree_type \
  --seed $seed \
  --n_repeat 1 \
  --n_jobs 1 \
