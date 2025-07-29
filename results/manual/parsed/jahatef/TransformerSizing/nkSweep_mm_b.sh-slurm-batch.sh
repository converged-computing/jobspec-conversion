#!/bin/bash
#SBATCH --job-name=benchmarks
#SBATCH --account=neox
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:8
#SBATCH --mem=16GB
#SBATCH --partition=g40x
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=8

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
export DLTS_HOSTFILE='/fsx/home-jacob/hostfiles/hosts_$SLURM_JOBID'

source /fsx/home-jacob/setup.sh
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
TRAIN_PATH=/fsx/home-jacob/TransformerSizing
cd $TRAIN_PATH
bash /fsx/home-jacob/write_hostfile.sh
export DLTS_HOSTFILE=/fsx/home-jacob/hostfiles/hosts_$SLURM_JOBID
python mm_flops.py >> results/vocab.out
