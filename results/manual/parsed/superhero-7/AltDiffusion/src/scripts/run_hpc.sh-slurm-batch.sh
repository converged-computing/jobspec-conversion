#!/bin/bash
#SBATCH --job-name=aesthetic
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --constraint=ntasks-per-node=8

export PYTHONPATH='$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

source /fsx/zacliu/altclip_env/bin/activate
export PYTHONPATH=$PYTHONPATH:/fsx/zacliu/AltTools/Altdiffusion/src
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python -u /fsx/zacliu/AltTools/Altdiffusion/src/scripts/train_hpc.py > /fsx/zacliu/AltTools/Altdiffusion/ckpt/laion_aethetics_all_512_xformer_ema_cfg/log.txt 2>&1
