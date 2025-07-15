#!/bin/bash
#FLUX: --job-name=mmsrl
#FLUX: -c=10
#FLUX: -t=36000
#FLUX: --urgency=16

export DATA_PATH='$WORK/data'
export TRANSFORMERS_CACHE='$HOME/.cache/huggingface/transformers'
export TRANSFORMERS_OFFLINE='1'

cd $WORK/mmsrl
module purge
source ~/.bashrc
conda activate pytorch
export DATA_PATH=$WORK/data
export TRANSFORMERS_CACHE=$HOME/.cache/huggingface/transformers
export TRANSFORMERS_OFFLINE=1
base_config=("--features_path=features_b7 --use_sbert=True --use_caption=True --use_entities=True --use_visualbert=True --use_clip=True"
             "--use_clip=True"
             "--features_path=features_b7 --use_clip=True"
             "--features_path=features_vgg --use_clip=True"
             "--features_path=features_frcnn --use_clip=True"
             "--features_path='all' --use_caption=True --use_clip=True"
             "--features_path='all' --use_sbert=True --use_entities=True --use_clip=True"
             "--features_path='all' --use_visualbert=True --use_clip=True")
base_name=("all"
           "clip"
           "b7"
           "vgg"
           "frcnn"
           "caption"
           "entities"
           "visualbert")
DIRNAME=generic_features_attention
mkdir $WORK/outputs/$DIRNAME
iconfig=$(($SLURM_ARRAY_TASK_ID%8))
config=${base_config[$iconfig]}
name=${base_name[$iconfig]}}
python -m mmsrl.train configs/generic.py --pooling=attention $config \
    --patience=26 --batch_per_epoch=1000 \
    --cyclic_subsample=None --subsample_labels='interpolate_micro_to_macro' \
    --output_val=\"$WORK/outputs/$DIRNAME/val_${name}_${SLURM_ARRAY_TASK_ID}.pkl\" \
    --output_test=\"$WORK/outputs/$DIRNAME/test_${name}_${SLURM_ARRAY_TASK_ID}.pkl\"
