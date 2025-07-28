#!/bin/bash
#FLUX: --job-name=fsdp-multi-node-test
#FLUX: --queue=a40x
#FLUX: --urgency=16

export MASTER_PORT='12340'
export WORLD_SIZE='$(($SLURM_JOB_NUM_NODES * $SLURM_GPUS_PER_NODE))'
export MASTER_ADDR='$master_addr'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export OMPI_MCA_mtl_base_verbose='1'
export FI_PROVIDER='efa'
export NCCL_TREE_THRESHOLD='0'
export NCCL_DEBUG='ERROR'
export NCCL_SOCKET_TIMEOUT='600000 # Set the timeout to 10 minutes (60000 milliseconds)'
export NCCL_DEBUG_SUBSYS='ALL'
export TORCH_DISTRIBUTED_DEBUG='INFO'
export NCCL_IBEXT_DISABLE='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export OMPI_MCA_btl='^openib'

echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
export MASTER_PORT=12340
export WORLD_SIZE=$(($SLURM_JOB_NUM_NODES * $SLURM_GPUS_PER_NODE))
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
echo "Starting python script"
module load cuda/11.8
SHARED_VOLUME_DIR=/weka/home-$(whoami)
source $SHARED_VOLUME_DIR/py_venvs/fsdp-qlora-py311/bin/activate
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export FI_EFA_ENABLE_SHM_TRANSFER=0
export OMPI_MCA_mtl_base_verbose=1
export FI_PROVIDER=efa
export NCCL_TREE_THRESHOLD=0
export NCCL_DEBUG=ERROR
export NCCL_SOCKET_TIMEOUT=600000 # Set the timeout to 10 minutes (60000 milliseconds)
export NCCL_DEBUG_SUBSYS=ALL
export TORCH_DISTRIBUTED_DEBUG=INFO
export NCCL_IBEXT_DISABLE=1
export NCCL_SOCKET_IFNAME=^docker0,lo
export OMPI_MCA_mtl_base_verbose=1
export OMPI_MCA_btl="^openib"
echo "Using python from $(which python)"
echo "Using torch from $(python -c 'import torch; print(torch.__file__)')"
echo "Using torch cuda from $(python -c 'import torch; print(torch.version.cuda)')"
echo "Using nccl from $(python -c 'import torch; print(torch.cuda.nccl.version())')"
echo "CUDA_HOME=$CUDA_HOME"
MAX_BATCH_SIZE=8
GRAD_ACCUM_STEPS=1
srun python $SHARED_VOLUME_DIR/git/fsdp_qlora/train.py \
--world_size=$WORLD_SIZE \
--master_addr=$MASTER_ADDR \
--master_port=$MASTER_PORT \
--model_name meta-llama/Llama-2-7b-hf \
--dataset dummy \
--batch_size $MAX_BATCH_SIZE \
--context_length 512 \
--gradient_accumulation_steps $GRAD_ACCUM_STEPS \
--train_type custom_qlora \
--use_gradient_checkpointing True \
--use_activation_cpu_offload True \
--use_cpu_offload False \
--log_to stdout \
--verbose true
