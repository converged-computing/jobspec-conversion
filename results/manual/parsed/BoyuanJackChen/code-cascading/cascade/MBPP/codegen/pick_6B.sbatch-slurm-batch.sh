#!/bin/bash
#SBATCH --job-name=6B_mbpp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=100GB
#SBATCH --time=2-23:59:59
#SBATCH --constraint=80g,ntasks-per-node=1

export TRANSFORMERS_CACHE='/scratch/bc3194/huggingface_cache'

module purge
MODEL=2
TEST_LINES=1
NUM_LOOPS=10
source ~/.bashrc
conda activate cascade
export TRANSFORMERS_CACHE="/scratch/bc3194/huggingface_cache"
python -u pick_at_k.py --model=$MODEL --test_lines=$TEST_LINES --num_loops=$NUM_LOOPS --pass_at=$SLURM_ARRAY_TASK_ID
