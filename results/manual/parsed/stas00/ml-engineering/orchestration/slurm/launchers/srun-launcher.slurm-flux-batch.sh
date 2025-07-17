#!/bin/bash
#FLUX: --job-name=srun-launcher
#FLUX: -N=2
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: --queue=xyz-cluster
#FLUX: -t=600
#FLUX: --urgency=16

export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='6000'
export WORLD_SIZE='$SLURM_NPROCS'
export CMD='$LAUNCHER $PROGRAM'

echo "START TIME: $(date)"
set -eo pipefail
set -x
LOG_PATH="main_log.txt"
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=6000
export WORLD_SIZE=$SLURM_NPROCS
LAUNCHER="python -u"
PROGRAM="torch-distributed-gpu-test.py"
export CMD="$LAUNCHER $PROGRAM"
echo $CMD
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    --jobid $SLURM_JOB_ID \
    "
srun $SRUN_ARGS bash -c "RANK=\$SLURM_PROCID LOCAL_RANK=\$SLURM_LOCALID $CMD" 2>&1 | tee -a $LOG_PATH
echo "END TIME: $(date)"
