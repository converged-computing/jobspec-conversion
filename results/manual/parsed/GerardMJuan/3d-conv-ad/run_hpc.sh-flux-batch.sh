#!/bin/bash
#FLUX: --job-name=moolicious-earthworm-2562
#FLUX: --priority=16

export PATH='/homedtic/gmarti/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
export PATH="/homedtic/gmarti/project/anaconda3/bin:$PATH"
source activate dlnn
module load CUDA/9.0.176
module load cuDNN/7.0.5-CUDA-9.0.176
python /homedtic/gmarti/CODE/3d-conv-ad/train.py --config_file /homedtic/gmarti/CODE/3d-conv-ad/configs/config_train.ini --output_directory_name test_3D3
