#!/bin/bash
#FLUX: --job-name=astute-parsnip-7578
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --urgency=16

module load tensorflow/1.0.1-cuda-foss-2016b
module load Python/3.6.1-foss-2016b
source $FATSDIR/virtualenvs/project_py3/bin/activate		# load virtual environemt 
cd /fast/users/a1699138/pattern_recognition/train_model/run 
python ../models-master/research/object_detection/train.py --logtostderr --pipeline_config_path=ssd_mobile_net_v1.config  --train_dir=train
deactivate							#deactivate virtual environment
