#!/bin/bash
#FLUX: --job-name=red-house-1060
#FLUX: -N=16
#FLUX: -c=32
#FLUX: -t=21600
#FLUX: --priority=16

export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

config_file=./config/AFNO.yaml
config='afno_backbone_finetune'
run_num='0'
export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
set -x
srun -u --mpi=pmi2 shifter \
    bash -c "
    source export_DDP_vars.sh
    python train.py --enable_amp --yaml_config=$config_file --config=$config --run_num=$run_num
    "
