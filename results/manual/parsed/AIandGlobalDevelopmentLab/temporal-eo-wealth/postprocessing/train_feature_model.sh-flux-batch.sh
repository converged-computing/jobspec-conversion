#!/bin/bash
#FLUX: --job-name=wobbly-egg-5167
#FLUX: --priority=16

data_dir=${1}
model_name=${2}
model_fold=${3}
fold_config=${4}
echo "Data directory: $data_dir";
echo "Model name: $model_name";
echo "Model fold: $model_fold";
echo "Fold config: $fold_config";
singularity run -B /mimer/NOBACKUP/groups/globalpoverty1/ /cephyr/NOBACKUP/groups/globalpoverty1/singularity_imgs/container_latest.sif train_feature_model.py --data_dir=$data_dir --model_name=$model_name --model_fold=$model_fold --fold_config=$fold_config --save_new_weights
