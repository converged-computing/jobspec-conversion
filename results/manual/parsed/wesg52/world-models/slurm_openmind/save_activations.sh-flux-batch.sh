#!/bin/bash
#FLUX: --job-name=eccentric-cattywampus-0172
#FLUX: -c=20
#FLUX: -t=10800
#FLUX: --urgency=16

export PATH='$ORDINAL_PROBING_ROOT:$PATH'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export RESULTS_DIR='/om2/user/wesg/world_models/results'
export ACTIVATION_DATASET_DIR='/om2/user/wesg/world_models/activation_datasets'
export FEATURE_DATASET_DIR='$ORDINAL_PROBING_ROOT/feature_datasets/processed_datasets'
export TRANSFORMERS_CACHE='/om/user/wesg/models'
export HF_HOME='/om/user/wesg/models'

export PATH=$ORDINAL_PROBING_ROOT:$PATH
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export RESULTS_DIR=/om2/user/wesg/world_models/results
export ACTIVATION_DATASET_DIR=/om2/user/wesg/world_models/activation_datasets
export FEATURE_DATASET_DIR=$ORDINAL_PROBING_ROOT/feature_datasets/processed_datasets
export TRANSFORMERS_CACHE=/om/user/wesg/models
export HF_HOME=/om/user/wesg/models
sleep 0.1  # wait for paths to update
/om2/user/wesg/anaconda/bin/activate interp
python -u save_activations.py --model $1 --entity_type $2 --batch_size $3 --prompt_name $4
