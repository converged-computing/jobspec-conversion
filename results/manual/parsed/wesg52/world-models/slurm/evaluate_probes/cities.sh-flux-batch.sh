#!/bin/bash
#FLUX: --job-name=wobbly-arm-5850
#FLUX: --urgency=16

export PATH='$ORDINAL_PROBING_ROOT:$PATH'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export RESULTS_DIR='/home/gridsan/wgurnee/mechint/ordinal-probing/results'
export FEATURE_DATASET_DIR='$ORDINAL_PROBING_ROOT/feature_datasets/processed_datasets'
export TRANSFORMERS_CACHE='/home/gridsan/groups/maia_mechint/models'
export HF_DATASETS_CACHE='/home/gridsan/groups/maia_mechint/ordinal_probing/hf_home'
export HF_HOME='/home/gridsan/groups/maia_mechint/ordinal_probing/hf_home'

export PATH=$ORDINAL_PROBING_ROOT:$PATH
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export RESULTS_DIR=/home/gridsan/wgurnee/mechint/ordinal-probing/results
export FEATURE_DATASET_DIR=$ORDINAL_PROBING_ROOT/feature_datasets/processed_datasets
export TRANSFORMERS_CACHE=/home/gridsan/groups/maia_mechint/models
export HF_DATASETS_CACHE=/home/gridsan/groups/maia_mechint/ordinal_probing/hf_home
export HF_HOME=/home/gridsan/groups/maia_mechint/ordinal_probing/hf_home
sleep 0.1  # wait for paths to update
source $ORDINAL_PROBING_ROOT/ord/bin/activate
sleep 0.1  # wait for paths to update
python -u evaluate_probes.py \
    --experiment_name $1 \
    --experiment_type $2 \
    --evaluation_type $3 \
    --model $4 \
    --entity_type city \
    --feature_name latitude
python -u evaluate_probes.py \
    --experiment_name $1 \
    --experiment_type $2 \
    --evaluation_type $3 \
    --model $4 \
    --entity_type city \
    --feature_name longitude
python -u evaluate_probes.py \
    --experiment_name $1 \
    --experiment_type $2 \
    --evaluation_type $3 \
    --model $4 \
    --entity_type city \
    --feature_name population
