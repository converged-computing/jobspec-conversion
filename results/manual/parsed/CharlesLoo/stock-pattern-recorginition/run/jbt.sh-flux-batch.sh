#!/bin/bash
#FLUX: --job-name=expensive-pancake-9470
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/fast/users/a1699138/pattern_recognition/train_model/models-master/research:/fast/users/a1699138/pattern_recognition/train_model/models-master/research/slim'

module load Python/3.6.1-foss-2016b
source /fast/users/a1699138/virtualenvs/project_py3/bin/activate		# load virtual environemt 
export PYTHONPATH=$PYTHONPATH:/fast/users/a1699138/pattern_recognition/train_model/models-master/research:/fast/users/a1699138/pattern_recognition/train_model/models-master/research/slim
cd /fast/users/a1699138/pattern_recognition/train_model/run 
python ../models-master/research/object_detection/train.py --logtostderr --pipeline_config_path=frcnn_resnet_50.config  --train_dir=train #--num_clones=4 --ps_tasks=1
deactivate							#deactivate virtual environment
