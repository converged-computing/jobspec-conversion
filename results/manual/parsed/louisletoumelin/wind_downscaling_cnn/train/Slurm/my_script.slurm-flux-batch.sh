#!/bin/bash
#FLUX: --job-name=wind_downscaling
#FLUX: --queue=nodes123
#FLUX: -t=43200
#FLUX: --urgency=16

HOME_DIR="/home/mrmn/letoumelinl/train"
DATA_DIR="/scratch/mrmn/letoumelinl/ARPS"
PYTHON_SCRIPT="/home/mrmn/letoumelinl/train/train_models.py"
HOROVOD_CONTAINER="horovod:env_DLv2" #container name
SLURM_HOSTLIST=$(scontrol show hostnames|paste -d, -s)
echo "SLURM_HOSTLIST: ${SLURM_HOSTLIST}"
UID="$((`id -u`))"
GID="$((`id -g`))"
ARGS=$1
ARGS2="${ARGS//|/ }"
NB_SECONDARY_WORKERS=$((SLURM_JOB_NUM_NODES-1))
if (( ${NB_SECONDARY_WORKERS} > 0 ))
then
    echo "Start containers of secondary nodes"
    #echo srun -x $(hostname -s) --nodes=${NB_SECONDARY_WORKERS} --ntasks-per-node=1 --ntasks=${NB_SECONDARY_WORKERS} slurm-docker-run secondary $HOROVOD_CONTAINER $UID $GID $HOME_DIR $DATA_DIR $PYTHON_SCRIPT $ARGS2
    srun -x $(hostname -s) --nodes=${NB_SECONDARY_WORKERS} --ntasks-per-node=1 --ntasks=${NB_SECONDARY_WORKERS} slurm-docker-run secondary $HOROVOD_CONTAINER $UID $GID $HOME_DIR $DATA_DIR $PYTHON_SCRIPT $ARGS &
fi
sleep 10
echo "Start Horovod on the primary node..."
srun -w $(hostname -s) --nodes=1 --ntasks-per-node=1 --ntasks=1 slurm-docker-run primary $HOROVOD_CONTAINER $UID $GID $HOME_DIR $DATA_DIR $PYTHON_SCRIPT $ARGS
