#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# Flux directives translated from SBATCH
#SBATCH --job-name=train                     -> #flux: --job-name=train_pfl_array
#SBATCH --comment="GLDv2 lr"                 -> (Informational, no direct Flux script equivalent)
#SBATCH --partition=learnfair                -> #flux: --queue=learnfair
#SBATCH --output=/checkpoint/pillutla/pfl/outs/%A_%a.out -> #flux: --output=/checkpoint/pillutla/pfl/outs/flux_{jobid}.{taskid}.out
#SBATCH --array=0-4                          -> #flux: --tasks=5 
#SBATCH --nodes=1                            -> #flux: -N 1
#SBATCH --cpus-per-task=10                   -> #flux: -c 10
#SBATCH --mem=40G                            -> #flux: --mem-per-task=40G
#SBATCH --gres=gpu:1                         -> #flux: --gpus-per-task=1
#SBATCH --time=2:00:00                       -> #flux: -t 2h
#SBATCH --open-mode=append                   -> (Flux default behavior for unique output files is sufficient)

# Flux directives for the job array tasks:
# Each of the 5 tasks will get these resources.
#flux: --tasks=5
#flux: -N 1
#flux: -c 10
#flux: --mem-per-task=40G
#flux: --gpus-per-task=1
#flux: -t 2h
#flux: --queue=learnfair
#flux: --job-name=train_pfl_array
#flux: --output=/checkpoint/pillutla/pfl/outs/flux_{jobid}.{taskid}.out
# It's good practice to also specify error, though default might combine with output:
#flux: --error=/checkpoint/pillutla/pfl/outs/flux_{jobid}.{taskid}.err


source ~/.bashrc  # load all modules
source activate pyt19  # load environment


echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
# Use Flux environment variables
echo "Flux Job id = ${FLUX_JOB_ID}, Flux task id = ${FLUX_TASK_ID}"
echo "PWD = $(pwd)"
echo "python path = $(which python)"

set -exu

# Default arguments
logdir="/checkpoint/pillutla/pfl/outputs3"
savedir="/checkpoint/pillutla/pfl/saved_models3"
common_args="--dataset gldv2  --model_name resnet18 --train_batch_size 64 --eval_batch_size 128 "
common_args="${common_args} --lr 1e-3  "


# Populate the array
list_of_jobs=()

# Renamed loop variable 'seed' to 'seed_val' to avoid conflict with the 'seed' command
# and to improve clarity.
seed_val_loop_var=1 # Original script uses 'seed=1' for the loop, implying a single seed value.
state="stateful"
init="pretrained"
pfl_algo="fedalt"
train_mode="adapter"

for current_seed in ${seed_val_loop_var} # Original: for seed in 1
do
for reg_param in 1000 100 10 1 0.1
do
pretrained_name="gldv2b_resnetgn_${train_mode}_${pfl_algo}_reg${reg_param}_${init}_${state}_seed${current_seed}"
for ne in 5
do
    name="${pretrained_name}_ne${ne}"
    task_params="--num_epochs_personalization ${ne} \
        --client_var_l2_reg_coef ${reg_param} --client_var_prox_to_init \
        --pretrained_model_path ${savedir}/${pretrained_name}/checkpoint.pt \
        --seed ${current_seed} --personalize_on_client ${train_mode} \
        --logfilename ${logdir}/${name} --savedir ${savedir}/${name}"
    list_of_jobs+=("${task_params}")
done # ne
done # reg_param
done # current_seed


# Run
num_jobs=${#list_of_jobs[@]}
# FLUX_TASK_ID is 0-indexed, suitable for array indexing
job_id=${FLUX_TASK_ID}

if [ ${job_id} -ge ${num_jobs} ] ; then
    echo "Invalid Flux task id ${job_id} (num_jobs is ${num_jobs}); quitting"
    # This indicates a mismatch between --tasks=N and the generated parameter sets.
    # The original script's --array=0-4 (5 tasks) matches the 1*5*1=5 generated jobs.
    exit 2
fi
echo "-------- STARTING FLUX TASK ${job_id}/${num_jobs}"
args=${list_of_jobs[${job_id}]}

time python -u train_finetune.py \
        ${common_args} \
        ${args}

echo "Job task ${FLUX_TASK_ID} completed at $(date)"