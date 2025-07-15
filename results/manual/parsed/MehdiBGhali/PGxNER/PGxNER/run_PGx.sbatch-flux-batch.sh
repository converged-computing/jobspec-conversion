#!/bin/bash
#FLUX: --job-name=PGxCorpus_training
#FLUX: --queue=gpu_prod_long
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate final_PGx_env
python ./BARTNER_adapted/train.py --dataset_name PGxCorpus --history_dir ./training_history  --save_model 1 \
--n_epochs 100 --max_len 10 --max_len_a 1.6 --num_beams 3 --bart_name facebook/bart-large
