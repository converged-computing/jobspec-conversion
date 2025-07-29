#!/bin/bash
#SBATCH --job-name=afno
#SBATCH --account=usup
#SBATCH --output=afno_backbone_finetune.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=06:00:00
#SBATCH --partition=nvgpu
#SBATCH --constraint=gpu,ntasks-per-node=4

export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

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
