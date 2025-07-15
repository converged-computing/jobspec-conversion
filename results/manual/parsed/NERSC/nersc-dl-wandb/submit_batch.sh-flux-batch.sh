#!/bin/bash
#FLUX: --job-name=peachy-plant-5105
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --priority=16

export FI_MR_CACHE_MONITOR='userfaultfd'
export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

config_file=./config/default.yaml
config="test2"
run_num="0"
env=/global/homes/s/shas1693/.local/perlmutter/nersc_pytorch_ngc-22.09-v0
export FI_MR_CACHE_MONITOR=userfaultfd
export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
scratch="$SCRATCH/results/logging_tests/"
cmd="python train.py --yaml_config=$config_file --config=$config --run_num=$run_num --root_dir=$scratch"
set -x
srun -l shifter --env PYTHONUSERBASE=${env} \
    bash -c "
    source export_DDP_vars.sh
    $cmd
    " 
