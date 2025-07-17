#!/bin/bash
#FLUX: --job-name=llama_recipes
#FLUX: -N=4
#FLUX: -n=4
#FLUX: --queue=advanced
#FLUX: -t=43200
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/home/abc/FZI-WIM-NLI4CT'
export FI_PROVIDER='efa'
export LOGLEVEL='INFO'
export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='INFO'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'

module load system/ssh_wrapper
module load devel/cuda/11.8
source /home/abc/anaconda3/etc/profile.d/conda.sh
conda activate llama_recipes
export PYTHONPATH=$PYTHONPATH:/home/abc/FZI-WIM-NLI4CT
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
export FI_PROVIDER="efa"
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=INFO
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
srun torchrun --nproc_per_node 4 --nnodes 4  --rdzv_id $RANDOM --rdzv_backend c10d --rdzv_endpoint $head_node_ip:29500 fsdp/lora_finetuning.py  --enable_fsdp --use_peft --peft_method lora --low_cpu_fsdp
