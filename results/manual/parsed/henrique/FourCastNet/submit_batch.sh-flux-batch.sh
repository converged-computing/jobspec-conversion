#!/bin/bash
#FLUX: --job-name=confused-onion-8214
#FLUX: -N=2
#FLUX: -c=32
#FLUX: --queue=nvgpu
#FLUX: -t=21600
#FLUX: --urgency=16

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
