#!/bin/bash
#FLUX: --job-name=restormer-universal-rician-15
#FLUX: -c=64
#FLUX: --queue=dc-gpu
#FLUX: -t=86400
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')'
export NCCL_DEBUG='INFO'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export NUM_GPU_PER_NODE='4'

echo 'Experiment start !'
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)"
MASTER_ADDR="${MASTER_ADDR}i"
export MASTER_ADDR="$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')"
export NCCL_DEBUG=INFO
export CUDA_VISIBLE_DEVICES=0,1,2,3
export NUM_GPU_PER_NODE=4
CONFIG=Denoising/Options/GaussianGrayDenoising_Restormer_universal_rician_15.yml
source /p/project/delia-mp/lin4/Julich_experiment/Restormer/restormer_env/activate.sh
srun python3 -m torch.distributed.launch \
    --nproc_per_node=4 \
    basicsr/train.py \
    -opt $CONFIG \
    --launcher pytorch;
echo 'Experiment End !'
