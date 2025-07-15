#!/bin/bash
#FLUX: --job-name=wobbly-parrot-5708
#FLUX: -t=3600
#FLUX: --urgency=16

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
