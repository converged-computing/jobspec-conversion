#!/bin/bash
#FLUX: --job-name=mathlm
#FLUX: -N=2
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: --queue=g40423
#FLUX: --urgency=16

export NCCL_DEBUG='WARN'
export NCCL_TREE_THRESHOLD='0'
export NCCL_PROTO='simple'
export NCCL_IBEXT_DISABLE='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export PYTHONFAULTHANDLER='1'
export OMPI_MCA_mtl_base_verbose='1'
export OMPI_MCA_btl='^openib'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export TORCHELASTIC_ERROR_FILE='$TRAIN_PATH/tmp/torch-elastic-error.json'
export TORCH_EXTENSIONS_DIR='./extensions/'
export DLTS_HOSTFILE='/fsx/zhangir.azerbayev/hostfiles/hosts_$SLURM_JOBID'
export WANDB_API_KEY='xxx'

source /fsx/hailey/conda_setup.sh
ds_report
export NCCL_DEBUG=WARN
export NCCL_TREE_THRESHOLD=0
export NCCL_PROTO=simple
export NCCL_IBEXT_DISABLE=1
export NCCL_SOCKET_IFNAME=^docker0,lo
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export PYTHONFAULTHANDLER=1
export OMPI_MCA_mtl_base_verbose=1
export OMPI_MCA_btl="^openib"
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
export TORCHELASTIC_ERROR_FILE=$TRAIN_PATH/tmp/torch-elastic-error.json
export TORCH_EXTENSIONS_DIR=./extensions/
TRAIN_PATH=/fsx/mathlm0/gpt-neox
cd $TRAIN_PATH
bash /fsx/quentin/write_hostfile.sh
export DLTS_HOSTFILE=/fsx/zhangir.azerbayev/hostfiles/hosts_$SLURM_JOBID
export WANDB_API_KEY=xxx
wandb login
python $TRAIN_PATH/deepy.py $TRAIN_PATH/train.py \
	        --conf_dir /fsx/mathlm0/gpt-neox/configs mathlm0_6B_train.yml
