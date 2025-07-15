#!/bin/bash
#FLUX: --job-name=joyous-poo-8119
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=600
#FLUX: --priority=16

export MASTER_ADDR='$(hostname)'

config_file=./configs/default.yaml
config="default"
run_num="ddp-shifter"
env=/global/homes/s/shas1693/.local/perlmutter/nersc_pytorch_ngc_23_07_v0
export MASTER_ADDR=$(hostname)
cmd="python train_multi_gpu.py --yaml_config=$config_file --config=$config --run_num=$run_num"
set -x
srun -l shifter --env PYTHONUSERBASE=${env} \
    bash -c "
    source export_DDP_vars.sh
    $cmd
    " 
