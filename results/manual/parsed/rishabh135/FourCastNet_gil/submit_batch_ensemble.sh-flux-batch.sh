#!/bin/bash
#FLUX: --job-name=cowy-fork-5033
#FLUX: -N=4
#FLUX: -c=32
#FLUX: --queue=regular
#FLUX: -t=900
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'
export MASTER_ADDR='$(hostname)'

export HDF5_USE_FILE_LOCKING=FALSE
export MASTER_ADDR=$(hostname)
launch="python inference/inference_ensemble.py --config=afno_backbone_finetune --run_num=0 --n_level=0.3"
srun --mpi=pmi2 -u -l shifter --module gpu --env PYTHONUSERBASE=$HOME/.local/perlmutter/nersc-pytorch-22.02-v0 bash -c "
    source export_DDP_vars.sh
    $launch
    "
