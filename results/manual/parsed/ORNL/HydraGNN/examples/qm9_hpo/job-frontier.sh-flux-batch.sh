#!/bin/bash
#FLUX: --job-name=blue-despacito-7912
#FLUX: --urgency=16

export MIOPEN_DISABLE_CACHE='1'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export NCCL_DEBUG='INFO'
export HF_HOME='$PWD/hfdata'
export NNODES='$SLURM_JOB_NUM_NODES # e.g., 100 total nodes'
export NNODES_PER_TRIAL='2'
export NUM_CONCURRENT_TRIALS='2'
export NTOTGPUS='$(( $NNODES * 8 )) # e.g., 800 total GPUs'
export NGPUS_PER_TRIAL='$(( 8 * $NNODES_PER_TRIAL )) # e.g., 32 GPUs per training'
export NTOT_DEEPHYPER_RANKS='$(( $NTOTGPUS / $NGPUS_PER_TRIAL )) # e.g., 25 total DH ranks'
export OMP_NUM_THREADS='4 # e.g., 8 threads per rank'
export DEEPHYPER_LOG_DIR='deephyper-experiment"-$SLURM_JOB_ID '
export DEEPHYPER_DB_HOST='$HOST'

set -x
export MIOPEN_DISABLE_CACHE=1
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export NCCL_DEBUG=INFO
export HF_HOME=$PWD/hfdata
HOSTS=.hosts-job$SLURM_JOB_ID
HOSTFILE=hostfile.txt
srun hostname > $HOSTS
sed 's/$/ slots=8/' $HOSTS > $HOSTFILE
export NNODES=$SLURM_JOB_NUM_NODES # e.g., 100 total nodes
export NNODES_PER_TRIAL=2
export NUM_CONCURRENT_TRIALS=2
export NTOTGPUS=$(( $NNODES * 8 )) # e.g., 800 total GPUs
export NGPUS_PER_TRIAL=$(( 8 * $NNODES_PER_TRIAL )) # e.g., 32 GPUs per training
export NTOT_DEEPHYPER_RANKS=$(( $NTOTGPUS / $NGPUS_PER_TRIAL )) # e.g., 25 total DH ranks
export OMP_NUM_THREADS=4 # e.g., 8 threads per rank
[ $NTOTGPUS -ne $(($NGPUS_PER_TRIAL*$NUM_CONCURRENT_TRIALS)) ] && echo "ERROR!!" 
export DEEPHYPER_LOG_DIR="deephyper-experiment"-$SLURM_JOB_ID 
mkdir -p $DEEPHYPER_LOG_DIR
export DEEPHYPER_DB_HOST=$HOST
sleep 5
echo "Doing something"
python qm9_deephyper_multi.py
