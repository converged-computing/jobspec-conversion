#!/bin/bash
#FLUX: --job-name=met_resnet101
#FLUX: --queue=normal
#FLUX: -t=21600
#FLUX: --urgency=16

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
cp ../../../analysis_scripts/make_metamers_imagenet_16_category_val_400_only_save_metamer_layers.py .
python make_metamers_imagenet_16_category_val_400_only_save_metamer_layers.py $SLURM_ARRAY_TASK_ID -I 3000 -N 8
