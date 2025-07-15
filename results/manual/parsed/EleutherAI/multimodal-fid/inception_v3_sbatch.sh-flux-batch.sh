#!/bin/bash
#FLUX: --job-name=neox
#FLUX: -c=32
#FLUX: --exclusive
#FLUX: --queue=compute-od-gpu
#FLUX: -t=18000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/aws-ofi-nccl/lib:/opt/amazon/efa/lib64:/usr/local/cuda-11.0/efa/lib:/usr/local/cuda-11.0/lib:/usr/local/cuda-11.0/lib64:/usr/local/cuda-11.0:/opt/nccl/build/lib:/opt/aws-ofi-nccl-install/lib:/opt/aws-ofi-nccl/lib:$LD_LIBRARY_PATH'
export PATH='/opt/amazon/efa/bin:$PATH'
export LD_PRELOAD='/opt/nccl/build/lib/libnccl.so'
export NCCL_DEBUG='INFO'
export NCCL_TREE_THRESHOLD='0'
export NCCL_PROTO='simple'
export NCCL_IBEXT_DISABLE='1'
export NCCL_SOCKET_IFNAME='eth0'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='1'
export OMPI_MCA_mtl_base_verbose='1'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export TORCHELASTIC_ERROR_FILE='$TRAIN_PATH/tmp/torch-elastic-error.json'

module load intelmpi
source /opt/intel/mpi/latest/env/vars.sh
export LD_LIBRARY_PATH=/opt/aws-ofi-nccl/lib:/opt/amazon/efa/lib64:/usr/local/cuda-11.0/efa/lib:/usr/local/cuda-11.0/lib:/usr/local/cuda-11.0/lib64:/usr/local/cuda-11.0:/opt/nccl/build/lib:/opt/aws-ofi-nccl-install/lib:/opt/aws-ofi-nccl/lib:$LD_LIBRARY_PATH
export PATH=/opt/amazon/efa/bin:$PATH
export LD_PRELOAD="/opt/nccl/build/lib/libnccl.so"
export NCCL_DEBUG=INFO
export NCCL_TREE_THRESHOLD=0
export NCCL_PROTO=simple
export NCCL_IBEXT_DISABLE=1
export NCCL_SOCKET_IFNAME="eth0"
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=1
export OMPI_MCA_mtl_base_verbose=1
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
echo go $COUNT_NODE
echo $HOSTNAMES
TRAIN_PATH=/fsx/dashiell/multimodal-fid
export TORCHELASTIC_ERROR_FILE=$TRAIN_PATH/tmp/torch-elastic-error.json
source $TRAIN_PATH/conda/bin/activate timm
cd $TRAIN_PATH
python3 $TRAIN_PATH/timm_train.py \
    --conf_dir configs 13B.yml eleutherai_cluster.yml
set +x
