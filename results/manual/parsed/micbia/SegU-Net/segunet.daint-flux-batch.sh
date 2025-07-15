#!/bin/bash
#FLUX: --job-name=segunet
#FLUX: -t=86400
#FLUX: --priority=16

module load daint-gpu
module load gcc/9.3.0
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
module load TensorFlow/2.4.0-CrayGNU-21.09
CONFIG_PATH="$SCRATCH/output_segunet/outputs/02-02T13-18-57_128slice"
source /project/c31/codes/miniconda3/etc/profile.d/conda.sh
conda activate segunet-env
python segUNet.py $CONFIG_PATH/net_RecUnet_lc.ini
conda deactivate
