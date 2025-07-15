#!/bin/bash
#FLUX: --job-name=astute-mango-9122
#FLUX: --priority=16

export PATH='$HOME/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
module load CUDA/9.0.176
module load cuDNN/7.0.5-CUDA-9.0.176
python /homedtic/gmarti/CODE/3d-conv-ad/train_res3dnet.py --config_file /homedtic/gmarti/CODE/3d-conv-ad/configs/config.ini --output_directory_name resnet_train
