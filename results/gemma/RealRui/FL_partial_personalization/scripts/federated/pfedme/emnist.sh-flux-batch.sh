#!/bin/bash
# Flux batch script generated from Slurm script

# Job name
#SBATCH --job-name=train

# Partition/Queue (Flux doesn't directly map to Slurm partitions, use resource constraints instead)
# Flux uses resource constraints to define where a job can run.  This is a placeholder.
# You'll need to adjust this based on your Flux cluster configuration.
# Example: --constraints="gpu"

# Output file
#SBATCH --output=/checkpoint/pillutla/pfl/outs/%A_%a.out

# Array job (Flux uses a different mechanism for array jobs, see below)
#SBATCH --array=0-4

# Resources
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G
#SBATCH --gres=gpu:1
#SBATCH --time=3:30:00

# Environment setup
source ~/.bashrc
conda activate pyt19

echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
echo "Job id = $(squeue -j $(echo $SLURM_JOB_ID) -o %i), task id = $(echo $SLURM_ARRAY_TASK_ID)" # Flux doesn't have SLURM_JOB_ID/SLURM_ARRAY_TASK_ID directly
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

# Run - Flux array job implementation
num_jobs=${#list_of_jobs[@]}
job_id=$(echo $SLURM_ARRAY_TASK_ID) # Use SLURM_ARRAY_TASK_ID as a placeholder for Flux array index
if [ ${job_id} -ge ${num_jobs} ] ; then
    echo "Invalid job id; qutting"
    exit 2
fi
echo "-------- STARTING JOB ${job_id}/${num_jobs}"
args=${list_of_jobs[${job_id}]}

time python -u train_pfl.py \
        ${common_args} \
        ${args}

echo "Job completed at $(date)"