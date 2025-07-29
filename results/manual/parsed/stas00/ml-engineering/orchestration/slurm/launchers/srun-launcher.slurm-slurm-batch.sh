#!/bin/bash
#SBATCH --job-name=srun-launcher
#SBATCH --output=%x-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:8
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

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
