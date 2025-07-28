#!/bin/bash
#FLUX: --job-name=benchmarks
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: --queue=g40
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
export DLTS_HOSTFILE='/fsx/quentin/jacob/hostfiles/hosts_$SLURM_JOBID'

source /fsx/quentin/jacob/gpt-neox-stuff/setup.sh
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
TRAIN_PATH=/fsx/quentin/jacob/gpt-neox-stuff/GEMMs_project/transformer_sizing/experiments/scripts
cd $TRAIN_PATH
bash /fsx/quentin/jacob/write_hostfile.sh
export DLTS_HOSTFILE=/fsx/quentin/jacob/hostfiles/hosts_$SLURM_JOBID
python printTorchVersion.py > torchVersion.txt
which python >> torchVersion.txt
pip show torch >> torchVersion.txt
