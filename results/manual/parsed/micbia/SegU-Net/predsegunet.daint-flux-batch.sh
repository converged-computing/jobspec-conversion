#!/bin/bash
#FLUX: --job-name=pred_segunet
#FLUX: -t=86400
#FLUX: --urgency=16

module load daint-gpu
module load gcc/9.3.0
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
module load TensorFlow/2.4.0-CrayGNU-21.09
CONFIG_PATH="$SCRATCH/output_segunet/outputs/all24-09T23-36-45_128slice"
source /project/c31/codes/miniconda3/etc/profile.d/conda.sh
conda activate segunet-env
python pred_segUNet.py $CONFIG_PATH/net_Unet_lc.ini
conda deactivate
