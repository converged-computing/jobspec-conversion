#!/bin/bash
# Flux batch script generated from SLURM script

# Job name
#SBATCH --job-name=train

# Partition/Queue (Flux doesn't directly map to SBATCH partitions, but you can use resource filters)
# Flux uses resource filters to specify where to run the job.  This is a placeholder.
# You'll need to adjust this based on your Flux cluster configuration.
# Example: --resources="partition=learnfair"

# Output file
#SBATCH --output=/checkpoint/pillutla/pfl/outs/%A_%a.out

# Array job
#SBATCH --array=0-4

# Resources
# Flux uses --cpus, --gpus, --memory, and --time
#SBATCH --cpus=10
#SBATCH --gpus=1
#SBATCH --memory=40G
#SBATCH --time=2:00:00

# Environment setup
source ~/.bashrc
conda activate pyt19

echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
echo "Job id = ${SLURM_JOB_ID}, task id = ${SLURM_ARRAY_TASK_ID}" #SLURM_JOB_ID and SLURM_ARRAY_TASK_ID are still available in Flux
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

seed=1
state="stateful"
init="pretrained"
pfl_algo="fedalt"
train_mode="adapter"

for seed in 1
do
for reg_param in 1000 100 10 1 0.1
do
pretrained_name="gldv2b_resnetgn_${train_mode}_${pfl_algo}_reg${reg_param}_${init}_${state}_seed${seed}"
for ne in 5
do
    name="${pretrained_name}_ne${ne}"
    task_params="--num_epochs_personalization ${ne} \
        --client_var_l2_reg_coef ${reg_param} --client_var_prox_to_init \
        --pretrained_model_path ${savedir}/${pretrained_name}/checkpoint.pt \
        --seed ${seed} --personalize_on_client ${train_mode} \
        --logfilename ${logdir}/${name} --savedir ${savedir}/${name}"
    list_of_jobs+=("${task_params}")
done # ne
done # reg_param
done # seed


# Run
num_jobs=${#list_of_jobs[@]}
job_id=${SLURM_ARRAY_TASK_ID}
if [ ${job_id} -ge ${num_jobs} ] ; then
    echo "Invalid job id; qutting"
    exit 2
fi
echo "-------- STARTING JOB ${job_id}/${num_jobs}"
args=${list_of_jobs[${job_id}]}

time python -u train_finetune.py \
        ${common_args} \
        ${args}

echo "Job completed at $(date)"
