#!/bin/bash
#FLUX: --job-name=llama-multi-cg1
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$(($SLURM_NTASKS_PER_NODE*$SLURM_JOB_NUM_NODES))'
export MASTER_ADDR='$master_addr'
export PMIX_MCA_psec='native'
export MELLANOX_VISIBLE_DEVICES='all'
export LOCAL_RANK='$SLURM_LOCALID'
export RANK='$SLURM_PROCID'
export OMP_NUM_THREADS='4'
export HF_HOME='$SCRIPT_DIR/hf_home'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:1024'

SCRIPT_DIR=$(pwd)
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "DIR:= $SCRIPT_DIR"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export WORLD_SIZE=$(($SLURM_NTASKS_PER_NODE*$SLURM_JOB_NUM_NODES))
echo "MASTER_PORT=$MASTER_PORT"
echo "WORLD_SIZE=$WORLD_SIZE"
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
export PMIX_MCA_psec=native
export MELLANOX_VISIBLE_DEVICES=all
export LOCAL_RANK=$SLURM_LOCALID
export RANK=$SLURM_PROCID
export OMP_NUM_THREADS=4
export HF_HOME=$SCRIPT_DIR/hf_home
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:1024
echo "Run started at:- "
date
srun --container-image="$SCRIPT_DIR/../enroot/nvidia+pytorch+24.01-llama-dev-py3.sqsh" \
    --container-mounts="$SCRIPT_DIR":"$SCRIPT_DIR" \
    --container-workdir="$SCRIPT_DIR" bash -c \
    "python examples/finetuning.py \
     --batch_size_training 2 \
     --fsdp_config.interleaved_offload_param 2 \
     --fsdp_config.interleaved_offload_act 2 \
     --fsdp_config.interleaved_ddp \
     --dist_checkpoint_root_folder model_checkpoints \
     --dist_checkpoint_folder fine-tuned \
     --model_name meta-llama/Llama-2-70b-hf \
     --use_fast_kernels \
     --fsdp_config.pure_bf16 \
     --use_peft \
     --gradient_accumulation_steps 10 \
     --max_steps_per_epoch 80"
echo ""
echo "################################################################"
echo "@@@@@@@@@@@@@@@@@@ Run completed at:- @@@@@@@@@@@@@@@@@@@@@@@@@"
date
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "################################################################"
