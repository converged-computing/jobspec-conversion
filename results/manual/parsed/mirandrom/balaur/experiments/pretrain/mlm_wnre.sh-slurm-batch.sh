#!/bin/bash
#FLUX: --job-name=mlm_wnre
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONFAULTHANDLER='1'
export BALAUR_CACHE='/network/scratch/m/mirceara/.cache/balaur'

conda_env="balaur"
home_dir="/home/mila/m/mirceara"
exp_dir="${home_dir}/balaur/experiments/pretrain"
script_path="${exp_dir}/run_bort.py"
run_from_path="${exp_dir}"
bashrc_path="${home_dir}/.bashrc"
seed=$SLURM_ARRAY_TASK_ID
args=" \
--experiment_name=mlm_wnre \
--dataset_name=wikibooks \
--large \
--wnre \
--wnre_factor=0.75 \
--tokenizer='roberta-base' \
--short_seq_prob=0.1 \
--complete_docs \
--devices=1 \
--num_nodes=8 \
--strategy='ddp' \
--per_device_bsz=128 \
--total_bsz=4096 \
--learning_rate=2e-3 \
--adam_wd=0.01 \
--lr_scheduler_name='linear' \
--num_warmup_steps=1500 \
--num_training_steps=25000 \
--save_every_n_steps=1000 \
--skip_eval \
--log_every_n_steps=10 \
--slurm_auto_requeue \
--no_timestamp_id \
--precision=16 \
--save_last \
--num_dataloader_workers=1 \
"
cd $run_from_path
pwd; hostname; date
source ${bashrc_path}
module load anaconda/3
activate $conda_env
export PYTHONFAULTHANDLER=1
export BALAUR_CACHE=/network/scratch/m/mirceara/.cache/balaur
cmd="srun python $script_path $args"
echo $cmd
eval $cmd
