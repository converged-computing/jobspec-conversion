#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=10
#FLUX: --queue=learnfair
#FLUX: -t=12600
#FLUX: --urgency=16

source ~/.bashrc  # load all modules
source activate pyt19  # load environment
echo "Running [ ${0} ${@} ] on $(hostname), starting at $(date)"
echo "Job id = ${SLURM_JOB_ID}, task id = ${SLURM_ARRAY_TASK_ID}"
echo "PWD = $(pwd)"
echo "python path = $(which python)"
set -exu
logdir="/checkpoint/pillutla/pfl/outputs3"
savedir="/checkpoint/pillutla/pfl/saved_models3"
common_args="--dataset emnist  --model_name resnet_gn --train_batch_size 32 --eval_batch_size 256 "
common_args="${common_args} --num_communication_rounds 500 --num_clients_per_round 10 --num_local_epochs 1"
common_args="${common_args}  --client_scheduler const --server_optimizer sgd --server_lr 1.0 --server_momentum 0.0 \
    --client_lr 0.01 --global_scheduler const_and_cut --global_lr_decay_factor 0.5 --global_lr_decay_every 500 \
        --pretrained_model_path /checkpoint/pillutla/pfl/saved_models2/emnist_pretrain_2000/checkpoint.pt \
    "
list_of_jobs=()
l2reg="0.1"
for seed in 1 2 3 4 5
do
    name="emnist_resnetgn_pfedme2_seed${seed}"
    task_params="--seed ${seed} --pfl_algo pfedme --pfedme_l2_reg_coef ${l2reg} --logfilename ${logdir}/${name} --savedir ${savedir}/${name}"
    list_of_jobs+=("${task_params}")
done  # l2reg
num_jobs=${#list_of_jobs[@]}
job_id=${SLURM_ARRAY_TASK_ID}
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
