#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

#FLUX: --job-name=train
#FLUX: --output=/checkpoint/pillutla/pfl/outs/%J_%t.out
#FLUX: --tasks=5                   # Corresponds to Slurm array 0-4 (5 tasks)
#FLUX: --tasks-per-node=1          # Each task on its own node (like Slurm's --nodes=1 per array task)
#FLUX: --cpus-per-task=10          # CPUs for each task
#FLUX: --gpus-per-task=1           # GPUs for each task
#FLUX: --mem-per-task=40G          # Memory for each task
#FLUX: -t 3h30m                    # Walltime
#FLUX: --queue=learnfair           # Assuming 'learnfair' is a queue name in Flux

# The --comment and --open-mode=append from Slurm:
# Flux does not have a direct --comment directive. Comments in the script serve this purpose.
# Flux --output appends by default if the file exists.

source ~/.bashrc  # load all modules
source activate pyt19  # load environment

echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
echo "Job id = ${FLUX_JOB_ID}, task id = ${FLUX_TASK_RANK}"
echo "PWD = $(pwd)"
echo "python path = $(which python)"

set -exu

# Default arguments
logdir="/checkpoint/pillutla/pfl/outputs3"
savedir="/checkpoint/pillutla/pfl/saved_models3"
common_args="--dataset emnist  --model_name resnet_gn --train_batch_size 32 --eval_batch_size 256 "
common_args="${common_args} --num_communication_rounds 500 --num_clients_per_round 10 --num_local_epochs 1"
common_args="${common_args}  --client_scheduler const --server_optimizer sgd --server_lr 1.0 --server_momentum 0.0 \
    --client_lr 0.01 --global_scheduler const_and_cut --global_lr_decay_factor 0.5 --global_lr_decay_every 500 \
        --pretrained_model_path /checkpoint/pillutla/pfl/saved_models2/emnist_pretrain_2000/checkpoint.pt \
    "


# Populate the array
list_of_jobs=()

l2reg="0.1"

for seed in 1 2 3 4 5
do
    name="emnist_resnetgn_pfedme2_seed${seed}"
    task_params="--seed ${seed} --pfl_algo pfedme --pfedme_l2_reg_coef ${l2reg} --logfilename ${logdir}/${name} --savedir ${savedir}/${name}"
    list_of_jobs+=("${task_params}")
done  # l2reg


# Run
num_jobs=${#list_of_jobs[@]}
job_id=${FLUX_TASK_RANK} # Use FLUX_TASK_RANK (0-indexed) instead of SLURM_ARRAY_TASK_ID

if [ ${job_id} -ge ${num_jobs} ] ; then
    echo "Invalid job id (${job_id}); num_jobs is ${num_jobs}. Quitting."
    exit 2
fi
echo "-------- STARTING JOB ${job_id}/${num_jobs}"
args=${list_of_jobs[${job_id}]}

time python -u train_pfl.py \
        ${common_args} \
        ${args}

echo "Job task ${FLUX_TASK_RANK} completed at $(date)"