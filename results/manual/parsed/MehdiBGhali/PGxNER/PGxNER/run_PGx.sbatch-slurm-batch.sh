#!/bin/bash
#SBATCH --job-name=PGxCorpus_training
#SBATCH --output=logslurms/PGxCorpus/slurm-%j.out
#SBATCH --error=logslurms/PGxCorpus/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=gpu_prod_long

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate final_PGx_env
python ./BARTNER_adapted/train.py --dataset_name PGxCorpus --history_dir ./training_history  --save_model 1 \
--n_epochs 100 --max_len 10 --max_len_a 1.6 --num_beams 3 --bart_name facebook/bart-large
