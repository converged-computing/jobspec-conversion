#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=big
#FLUX: -t=86400
#FLUX: --priority=16

export CODE_DIR='/jmain02/home/J2AD016/jjw02/jjs00-jjw02/scripts'      #PATH_TO_CODE_DIR'

module load python/anaconda3
module load cuda/11.2
source ~/.bashrc
source activate convnext2
export CODE_DIR='/jmain02/home/J2AD016/jjw02/jjs00-jjw02/scripts'      #PATH_TO_CODE_DIR
cd $CODE_DIR
wandb offline
wandb agent --count 1 SWEEP_ID
python 'CocoaReader/DisNet/Torch_Custom_CNNs.py' \
        --model_name 'DisNet18_v0.3' \
        --root '/jmain02/home/J2AD016/jjw02/jjs00-jjw02/dat' \
        --data_dir 'test' \
        --input_size 224 \
        --min_epochs 1 \
        --arch 'resnet18' \
        --initial_batch_size 37 \
        --patience 2
