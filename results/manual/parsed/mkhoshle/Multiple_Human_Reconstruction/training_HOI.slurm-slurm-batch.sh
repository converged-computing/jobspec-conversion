#!/bin/bash
#FLUX: --job-name=train_HOI
#FLUX: --queue=lgns
#FLUX: -t=2910000
#FLUX: --urgency=16

export TORCH_HOME='/z/home/mkhoshle/Human_object_transform/trained_models'
export WANDB_API_KEY='79be3522200691f5f2e70b838fb23f90d4577836'
export WANDB_CONFIG_DIR='/z/home/mkhoshle/Human_object_transform'
export WANDB_DIR='/z/home/mkhoshle/Human_object_transform'
export WANDB_CACHE_DIR='/z/home/mkhoshle/Human_object_transform'

module load cuda/10.2
conda activate /z/home/mkhoshle/env/romp2
export TORCH_HOME=/z/home/mkhoshle/Human_object_transform/trained_models
export WANDB_API_KEY=79be3522200691f5f2e70b838fb23f90d4577836
export WANDB_CONFIG_DIR=/z/home/mkhoshle/Human_object_transform
export WANDB_DIR=/z/home/mkhoshle/Human_object_transform
export WANDB_CACHE_DIR=/z/home/mkhoshle/Human_object_transform
echo `nvidia-smi`
rsync -avP /z/home/mkhoshle/dataset/ROMP_datasets/3DPW  $TMPDIR
TRAIN_CONFIGS='configs/v1.yml'
GPUS=$(cat $TRAIN_CONFIGS | shyaml get-value ARGS.GPUS)
DATASET=$(cat $TRAIN_CONFIGS | shyaml get-value ARGS.dataset)
TAB=$(cat $TRAIN_CONFIGS | shyaml get-value ARGS.tab)
cd /z/home/mkhoshle/Human_object_transform
python  HumanObj_videos_ResNet/train.py --GPUS=${GPUS} --configs_yml='configs/v1.yml' 
