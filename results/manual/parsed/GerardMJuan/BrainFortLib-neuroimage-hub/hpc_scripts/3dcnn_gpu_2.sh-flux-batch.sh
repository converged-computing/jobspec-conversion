#!/bin/bash
#FLUX: --job-name=c3d
#FLUX: --queue=high
#FLUX: --urgency=16

export PATH='$HOME/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
module load CUDA/9.0.176
module load cuDNN/7.0.5-CUDA-9.0.176
python /homedtic/gmarti/CODE/3d-conv-ad/train_c3d_slice.py --config_file /homedtic/gmarti/CODE/3d-conv-ad/configs/config_c3d.ini --output_directory_name c3d
