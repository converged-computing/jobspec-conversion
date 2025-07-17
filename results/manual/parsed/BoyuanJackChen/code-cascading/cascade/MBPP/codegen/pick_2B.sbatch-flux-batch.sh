#!/bin/bash
#FLUX: --job-name=2B_mbpp
#FLUX: --queue=nvidia
#FLUX: -t=259199
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='/scratch/bc3194/huggingface_cache'

module purge
MODEL=1
TEST_LINES=1
NUM_LOOPS=10
source ~/.bashrc
conda activate cascade
export TRANSFORMERS_CACHE="/scratch/bc3194/huggingface_cache"
python -u pick_at_k.py --model=$MODEL --test_lines=$TEST_LINES --num_loops=$NUM_LOOPS --pass_at=$SLURM_ARRAY_TASK_ID
