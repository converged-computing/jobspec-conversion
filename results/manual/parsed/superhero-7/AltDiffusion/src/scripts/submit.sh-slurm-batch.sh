#!/bin/bash
#FLUX: --job-name=laion5b
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=g40
#FLUX: -t=7200
#FLUX: --urgency=16

export NCCL_DEBUG='info'
export PYTHONFAULTHANDLER='1'
export NCCL_PROTO='simple'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export CUDA_LAUNCH_BLOCKING='0'
export OMPI_MCA_mtl_base_verbose='1'
export FI_EFA_ENABLE_SHM_TRANSFER='0'
export FI_PROVIDER='efa'
export FI_EFA_TX_MIN_CREDITS='64'
export NCCL_TREE_THRESHOLD='0'
export PYTHONPATH='$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src;'
export CUDA_VISIBLE_DEVICES='0,1,2,3,4,5,6,7;'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_PROTO=simple
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_EFA_USE_DEVICE_RDMA=1
export NCCL_DEBUG=info
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export OMPI_MCA_mtl_base_verbose=1
export FI_EFA_ENABLE_SHM_TRANSFER=0
export FI_PROVIDER=efa
export FI_EFA_TX_MIN_CREDITS=64
export NCCL_TREE_THRESHOLD=0
export PYTHONPATH=$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src;
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7;
srun --comment altdiffusion --partition=g40 --job-name=test_multi --nodes=8 --gres=gpu:8 --ntasks-per-node=2 --cpus-per-gpu=12 \
python3 -u /fsx/zacliu/AltTools/Altdiffusion/src/scripts/train_hpc.py > /fsx/zacliu/AltTools/Altdiffusion/src/laion5b.txt 2>&1
