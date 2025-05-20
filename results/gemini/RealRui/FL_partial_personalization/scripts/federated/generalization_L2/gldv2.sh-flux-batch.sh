#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

#FLUX: --job-name=train
# Original Slurm comment: "GLDv2 reg param"
#FLUX: -q learnfair                   # Assumes 'learnfair' is a Flux queue/partition
#FLUX: -o /checkpoint/pillutla/pfl/outs/%J_%t.out  # Output: %J is Job ID, %t is task rank
#FLUX: -N 1                           # Nodes per task
#FLUX: --tasks-per-node=1             # Tasks per node (ensures task exclusivity on the node)
#FLUX: -c 10                          # Cores per task
#FLUX: --mem-per-node=40G             # Memory per node for this task
#FLUX: -g 1                           # GPUs per task
#FLUX: -t 10:00:00                    # Walltime

# To submit this script for 25 tasks (equivalent to Slurm array 0-24):
# flux submit -n 25 ./your_flux_script_name.sh

source ~/.bashrc  # load all modules
source activate pyt19  # load environment

echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
echo "Job id = ${FLUX_JOB_ID}, task id = ${FLUX_TASK_RANK}" # Using Flux environment variables
echo "PWD = $(pwd)"
echo "python path = $(which python)"

set -exu

# Default arguments
logdir="/checkpoint/pillutla/pfl/outputs3"
savedir="/checkpoint/pillutla/pfl/saved_models3"
common_args="--dataset gldv2  --model_name resnet18 --train_batch_size 64 --eval_batch_size 128 "
common_args="${common_args} --num_communication_rounds 600 --num_clients_per_round 50 --num_local_epochs 1"
common_args="${common_args} --client_scheduler const --use_pretrained_model --log_test_every_n_rounds 150 \
            --global_scheduler linear --server_optimizer adam --server_lr 5e-5 --client_lr 1e-3  \
            --pretrained_model /checkpoint/pillutla/pfl/saved_models2/gldv2b_pretrain_2500/checkpoint.pt \
            "

# Populate the array
list_of_jobs=()

pfl_algo="fedalt"
train_mode="adapter"

for seed in 1 2 3 4 5
do
for reg_param in 1000 100 10 1 0.1
do
    name="gldv2b_resnetgn_${train_mode}_${pfl_algo}_reg${reg_param}_pretrained_stateful_seed${seed}"
    task_params="--client_var_l2_reg_coef ${reg_param} --client_var_prox_to_init"
    task_params="${task_params} --seed ${seed} --pfl_algo ${pfl_algo} --personalize_on_client ${train_mode} --logfilename ${logdir}/${name} --savedir ${savedir}/${name}"
    list_of_jobs+=("${task_params}")
done # reg param
done # seed


# Run
num_jobs=${#list_of_jobs[@]}
job_id=${FLUX_TASK_RANK} # Using FLUX_TASK_RANK (0-indexed)
if [ ${job_id} -ge ${num_jobs} ] ; then
    echo "Invalid job id ${job_id} (num_jobs is ${num_jobs}); quitting"
    exit 2
fi
echo "-------- STARTING JOB ${job_id}/${num_jobs}"
args=${list_of_jobs[${job_id}]}

time python -u train_pfl.py \
        ${common_args} \
        ${args}

echo "Job completed at $(date)"