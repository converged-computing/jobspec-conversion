#!/bin/bash
#SBATCH --output=out
#SBATCH --error=err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=4

export NCCL_DEBUG='INFO'
export NCCL_IB_CUDA_SUPPORT='0'
export NCCL_IB_DISABLE='1'

source ~/pyenv
ml purge
ml use $OTHERSTAGES
ml Stages/2019a
ml GCC/8.3.0
ml ParaStationMPI/5.4.4-1-CUDA
ml CUDA/10.1.105
ml NCCL/2.4.6-1-CUDA-10.1.105
ml cuDNN/7.5.1.10-CUDA-10.1.105
export NCCL_DEBUG=INFO
export NCCL_IB_CUDA_SUPPORT=0
export NCCL_IB_DISABLE=1
srun --cpu-bind=none,v --accel-bind=gn python -u train_alae.py --config-file configs/ffhq.yaml
