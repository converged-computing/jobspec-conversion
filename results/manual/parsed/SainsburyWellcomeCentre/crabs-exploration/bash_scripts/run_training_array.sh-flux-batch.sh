#!/bin/bash
#FLUX: --job-name=astute-parrot-1959
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/.bashrc
PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
set -e  # do not continue after errors
set -u  # throw error if variable is unset
set -o pipefail  # make the pipe fail if any part of it fails
EXPERIMENT_NAME="Sept2023"
MLFLOW_FOLDER=/ceph/zoo/users/sminano/ml-runs-all/ml-runs-scratch
DATASET_DIR=/ceph/zoo/users/sminano/crabs_bboxes_labels/Sep2023_labelled
TRAIN_CONFIG_FILE=/ceph/zoo/users/sminano/cluster_train_config.yaml
LIST_SEEDS=($(echo {42..44}))
SPLIT_SEED=${LIST_SEEDS[${SLURM_ARRAY_TASK_ID}]}
GIT_BRANCH=main
if [[ $SLURM_ARRAY_TASK_COUNT -ne ${#LIST_SEEDS[@]} ]]; then
    echo "The number of array tasks does not match the number of inputs"
    exit 1
fi
module load miniconda
ENV_NAME=crabs-dev-$SPLIT_SEED-$SLURM_ARRAY_JOB_ID
ENV_PREFIX=$TMPDIR/$ENV_NAME
conda create \
    --prefix $ENV_PREFIX \
    -y \
    python=3.10
conda activate $ENV_PREFIX
python -m pip install git+https://github.com/SainsburyWellcomeCentre/crabs-exploration.git@$GIT_BRANCH
echo $ENV_PREFIX
which python
which pip
echo "Git branch: $GIT_BRANCH"
conda list crabs
echo "-----"
echo "Memory used per GPU before training"
echo $(nvidia-smi --query-gpu=name,memory.total,memory.free,memory.used --format=csv) #noheader
echo "-----"
train-detector  \
 --dataset_dirs $DATASET_DIR \
 --config_file $TRAIN_CONFIG_FILE \
 --accelerator gpu \
 --experiment_name $EXPERIMENT_NAME \
 --seed_n $SPLIT_SEED \
 --mlflow_folder $MLFLOW_FOLDER \
