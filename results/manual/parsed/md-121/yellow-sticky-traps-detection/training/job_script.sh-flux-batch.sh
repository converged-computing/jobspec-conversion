#!/bin/bash
#FLUX: --job-name=tf_faster_rcnn_train
#FLUX: -t=3600
#FLUX: --priority=16

cd $HOME/master_thesis/yellow_sticky_network
module unload intelmpi
module switch intel gcc
module load python/3.6.8
module load cuda/101
module load cudnn/7.6.5
source ~/.zshrc
source venv/bin/activate
python3 model_main_tf2.py --model_dir=training/faster_rcnn/faster_rcnn_inception_resnet_v2_1024x1024_coco17_tpu-8 --pipeline_config_path=training/faster_rcnn/faster_rcnn_inception_resnet_v2_1024x1024_coco17_tpu-8/pipeline.config
