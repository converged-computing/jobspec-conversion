#!/bin/bash
#FLUX: --job-name=moebert_$1_$2
#FLUX: -c=4
#FLUX: -t=1814400
#FLUX: --urgency=16

export TOTAL_GPUS='${SLURM_NTASKS}'
export GPUS_PER_NODE='2'
export HF_HOME='${HF_LOCAL_DIR}'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export WANDB_DISABLED='true'
export BACKEND='pytorch'
export HDF5_USE_FILE_LOCKING='FALSE'
export output_dir='OUTPUT_TOFILL'

echo "Launching hash finetuning for dataset $1"
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
export output_dir=OUTPUT_TOFILL
bash sh_scripts/experiments/launch_jobs.sh $1 $output_dir $2
