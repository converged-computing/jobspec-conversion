#!/bin/bash
#FLUX: --job-name=openbioml
#FLUX: --queue=g40n404
#FLUX: --urgency=16

export NCCL_PROTO='simple'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export OMPI_MCA_mtl_base_verbose='1'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export NCCL_TREE_THRESHOLD='0'
export OMPI_MCA_pml='^cm'
export OMPI_MCA_btl='tcp,self'
export OMPI_MCA_btl_tcp_if_exclude='lo,docker1'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export WORLD_SIZE='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l)'
export JOB_COMMENT='Key=Monitoring,Value=ON'
export WANDB_DIR='/fsx/home-zanussbaum/bio-chem-lm/outputs/'
export WANDB_CACHE_DIR='/fsx/home-zanussbaum/.cache'
export WANDB_MODE='online'

export NCCL_PROTO=simple
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export OMPI_MCA_mtl_base_verbose=1
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export NCCL_TREE_THRESHOLD=0
export OMPI_MCA_pml="^cm"
export OMPI_MCA_btl="tcp,self"
export OMPI_MCA_btl_tcp_if_exclude="lo,docker1"
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export WORLD_SIZE=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l)
export JOB_COMMENT="Key=Monitoring,Value=ON"
export WANDB_DIR="/fsx/home-zanussbaum/bio-chem-lm/outputs/"
export WANDB_CACHE_DIR="/fsx/home-zanussbaum/.cache"
export WANDB_MODE="online"
echo MASTER_ADDR=${MASTER_ADDR}
echo MASTER_PORT=${MASTER_PORT}
echo WORLD_SIZE=${WORLD_SIZE}
module load cuda/11.7
source /fsx/home-zanussbaum/bio-chem-lm/env/bin/activate
cd /fsx/home-zanussbaum/bio-chem-lm/bio_lm
srun --comment openbioml --gres=gpu:1 --ntasks=1 wandb agent zanussbaum/bio-chem-lm/nj1zeot5
