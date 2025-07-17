#!/bin/bash
#FLUX: --job-name=serene
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.8.6
module load cuda/10.1 
module load tensorflow/2.3.1
CONFIG_PATH="$HOME/SegU-Net/config"
source $HOME/nnevn/bin/activate
python segUNet.py $CONFIG_PATH/net_Unet_lc.ini
deactivate
