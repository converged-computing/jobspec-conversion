#!/bin/bash
#FLUX: --job-name=anxious-pedo-0043
#FLUX: --exclusive
#FLUX: --urgency=16

export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='9901'

readonly training_script="train_ppo_llama.sh" 
readonly GPUS_PER_NODE=8
readonly PROJECT_PATH=$(cd ../../; pwd)
readonly IMAGE_NAME="nvcr.io/nvidia/pytorch:23.12-py3"
readonly JOBLOG="$(pwd)/logs/$training_script-$SLURM_JOB_ID.log"
mkdir logs
echo "$(date '+%Y-%m-%d %H:%M:%S') Job ${SLURM_JOB_ID} started ..." &>> ${JOBLOG}
source ./${training_script} slurm
echo training_commands &>> ${JOBLOG}
echo $training_commands &>> ${JOBLOG}
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=9901
srun --container-image="$IMAGE_NAME" \
    --container-mounts="$PROJECT_PATH:/root/openrlhf,$HOME/.cache:/root/.cache,$HOME/.local:/root/.local,\
$HOME/.triton:/root/.triton,/dev/null:/root/.bashrc" \
    bash -c "cd /root/openrlhf/examples/scripts; ./build_openrlhf.sh; torchrun \
--nproc_per_node $GPUS_PER_NODE --nnodes $SLURM_NNODES --node_rank $SLURM_PROCID \
--master_addr $MASTER_ADDR --master_port $MASTER_PORT ${training_commands}" &>> ${JOBLOG}
echo "$(date '+%Y-%m-%d %H:%M:%S') Job ${SLURM_JOB_ID} stopped ..." &>> ${JOBLOG}
