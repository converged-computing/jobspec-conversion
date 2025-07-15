#!/bin/bash
#FLUX: --job-name=bert_importance_squad
#FLUX: -c=4
#FLUX: -t=1440
#FLUX: --priority=16

export TOTAL_GPUS='${SLURM_NTASKS}'
export HF_HOME='${HF_LOCAL_DIR}'
export TRANSFORMERS_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export WANDB_DISABLED='true'
export BACKEND='pytorch'
export HDF5_USE_FILE_LOCKING='FALSE'
export output_dir='/home/gridsan/$(whoami)/MoEBERT-fork/results'

source /etc/profile
module load anaconda/2021b
source activate MoEBERT
export TOTAL_GPUS=${SLURM_NTASKS}
echo "Total number of GPUs: $TOTAL_GPUS"
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
export output_dir="/home/gridsan/$(whoami)/MoEBERT-fork/results"
for dset in mnli;
do
    bash sh_scripts/new_experiments/importance_preprocess_new.sh $dset $output_dir
    python merge_importance.py --task $dset
done
