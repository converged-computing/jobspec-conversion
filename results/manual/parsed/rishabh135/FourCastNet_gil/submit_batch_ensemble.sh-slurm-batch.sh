#!/bin/bash
#SBATCH --account=m4134_g
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:15:00
#SBATCH --partition=regular
#SBATCH --constraint=ntasks-per-node=4,gpu

export HDF5_USE_FILE_LOCKING='FALSE'
export MASTER_ADDR='$(hostname)'

singularity
exec
nersc/pytorch:ngc-22.02-v0
export HDF5_USE_FILE_LOCKING=FALSE
export MASTER_ADDR=$(hostname)
launch="python inference/inference_ensemble.py --config=afno_backbone_finetune --run_num=0 --n_level=0.3"
srun --mpi=pmi2 -u -l shifter --module gpu --env PYTHONUSERBASE=$HOME/.local/perlmutter/nersc-pytorch-22.02-v0 bash -c "
    source export_DDP_vars.sh
    $launch
    "
