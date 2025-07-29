#!/bin/bash
#SBATCH --job-name=afno
#SBATCH --output=afno_backbone_finetune.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:2
#SBATCH --time=01:00:00
#SBATCH --qos=gpu_8a100

export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

config_file=./config/AFNO.yaml
config='afno_backbone_tec_ustc'
run_num='1'
export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
set -x
srun -u --mpi=pmi2 \
    bash -c "
    source export_DDP_vars.sh
    python train.py --enable_amp --yaml_config=$config_file --config=$config --run_num=$run_num
    "
