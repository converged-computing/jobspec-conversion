#!/bin/bash -l
#SBATCH --time=06:00:00
#SBATCH -C gpu
#SBATCH --account=usup
#SBATCH --nodes=2
#SBATCH --partition=nvgpu
#SBATCH --ntasks-per-node=4
#SBATCH --gpus-per-node=4
#SBATCH --cpus-per-task=32
#SBATCH -J afno
# #SBATCH --image=nersc/pytorch:ngc-22.02-v0
#SBATCH -o afno_backbone_finetune.out

set -x
config_file=./config/AFNO.yaml
config='afno_backbone_finetune'
run_num='0'

export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB

export MASTER_ADDR=$(hostname)
conda activate cu113

srun -ul \
    bash -c "
    source export_DDP_vars.sh
    python train.py --enable_amp --yaml_config=$config_file --config=$config --run_num=$run_num
    "
