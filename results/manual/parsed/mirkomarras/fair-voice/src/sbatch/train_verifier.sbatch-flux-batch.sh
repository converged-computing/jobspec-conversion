#!/bin/bash
#FLUX: --job-name=ResNet34Vox
#FLUX: -t=604800
#FLUX: --urgency=16

export PRJ_PATH='${PWD}'
export AUDIO_DIR='/beegfs/mm10572/voxceleb1/dev,/beegfs/mm10572/voxceleb2/dev'
export VAL_BASE_PATH='/beegfs/mm10572/voxceleb1/test'
export NET='resnet34vox'
export PYTHONPATH='$PRJ_PATH'

module purge
module unload cuda/8.0.44
module load cuda/10.0.130
module load cudnn/10.0v7.6.2.24
module load ffmpeg/intel/3.2.2
export PRJ_PATH="${PWD}"
export AUDIO_DIR="/beegfs/mm10572/voxceleb1/dev,/beegfs/mm10572/voxceleb2/dev"
export VAL_BASE_PATH="/beegfs/mm10572/voxceleb1/test"
export NET="resnet34vox"
export PYTHONPATH=$PRJ_PATH
source $PRJ_PATH/mvenv/bin/activate
python -u $PRJ_PATH/routines/verifier/train.py --audio_dir $AUDIO_DIR --val_base_path $VAL_BASE_PATH --net $NET --learning_rate 0.01 --aggregation 'gvlad' --batch 32
