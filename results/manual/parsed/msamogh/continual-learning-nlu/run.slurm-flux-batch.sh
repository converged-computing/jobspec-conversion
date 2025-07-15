#!/bin/bash
#FLUX: --job-name=reclusive-dog-2609
#FLUX: --queue=gpu
#FLUX: --priority=16

module load git
module load python/3.8
module load cuda/11.4.3
cd continual-learning-nlu
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd cl_domain/
echo "Strategy = Min Path"
PYTHONPATH=$PYTHONPATH:$(pwd)/.. python run.py \
    --mode train \
    --cl_super_run_label max_path-studio-vest \
    --cl_checkpoint_dir ../cl_checkpoints \
    --cl_run_dir ../cl_runs \
    --results_dir ../cl_results \
    --ordering_strategy max_path \
    --num_train_epochs 18 \
    --num_runs 22 \
    --num_domains_per_run 5 \
    --cl_lr_schedule constant \
    --limit_n_samples 180 \
    --val_size_per_domain 0.01 \
    --cl_experience_replay_size 20 \
    --eval_batch_size 4 \
    --train_batch_size 4 \
PYTHONPATH=$PYTHONPATH:$(pwd)/.. python run.py \
    --mode evaluate \
    --cl_super_run_label max_path-studio-vest \
    --cl_checkpoint_dir ../cl_checkpoints \
    --cl_run_dir ../cl_runs \
    --results_dir ../cl_results \
    --ordering_strategy max_path \
    --num_train_epochs 5 \
    --num_runs 22 \
    --num_domains_per_run 5 \
    --cl_lr_schedule constant \
    --limit_n_samples 180 \
    --val_size_per_domain 0.01 \
    --cl_experience_replay_size 20 \
    --eval_batch_size 4 \
    --train_batch_size 4 \
