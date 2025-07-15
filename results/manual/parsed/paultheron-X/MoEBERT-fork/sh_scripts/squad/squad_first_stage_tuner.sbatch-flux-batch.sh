#!/bin/bash
#FLUX: --job-name=sticky-peanut-7304
#FLUX: -c=20
#FLUX: --queue=xeon-g6-volta
#FLUX: --priority=16

export TOTAL_GPUS='${SLURM_NTASKS}'
export GPUS_PER_NODE='2'
export HF_HOME='${HF_LOCAL_DIR}'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export WANDB_DISABLED='true'
export BACKEND='pytorch'
export HDF5_USE_FILE_LOCKING='FALSE'
export DATASET='${dsets[TASK_ID%2]}'
export SEED='${seeds[TASK_ID%5]}'
export output_dir='/home/gridsan/$(whoami)/MoEBERT-fork/results'

echo "Launching seeds finetuning for dataset $1"
source /etc/profile
module load anaconda/2021b
source activate MoEBERT
export TOTAL_GPUS=${SLURM_NTASKS}
export GPUS_PER_NODE=2
echo "Total number of GPUs: $TOTAL_GPUS"
echo "GPUs per node: $GPUS_PER_NODE"
if [ ! -e /proc/$(pidof nvidia-smi) ]
then
	echo "nvidia-smi does not seem to be running. exiting job"
    exit 1
fi
HF_USER_DIR="/home/gridsan/$(whoami)/.cache/huggingface"
HF_LOCAL_DIR="/state/partition1/user/$(whoami)/cache/huggingface"
mkdir -p $HF_LOCAL_DIR
rsync -a --ignore-existing $HF_USER_DIR/ ${HF_LOCAL_DIR}
export HF_HOME=${HF_LOCAL_DIR}
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export WANDB_DISABLED="true"
export BACKEND="pytorch"
export HDF5_USE_FILE_LOCKING=FALSE
cd /home/gridsan/$(whoami)/MoEBERT-fork
TASK_ID=$SLURM_ARRAY_TASK_ID
EXP_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
export DATASET=${dsets[TASK_ID%2]}
export SEED=${seeds[TASK_ID%5]}
echo $TASK_ID
echo $EXP_ID
export output_dir="/home/gridsan/$(whoami)/MoEBERT-fork/results"
srun bash sh_scripts/experiments/hyperparameter_metatuner.sh squad_v2 ${TASK_ID} $output_dir
