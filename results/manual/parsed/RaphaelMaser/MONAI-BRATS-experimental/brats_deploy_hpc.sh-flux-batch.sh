#!/bin/bash
#FLUX: --job-name=BRATS
#FLUX: -c=7
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export PATH='$HOME/miniconda/bin:$PATH'

sleep 2s
nvidia-smi
export PATH="$HOME/miniconda/bin:$PATH"
source activate MONAI-BRATS
python brats_deploy.py --input "data/Task01_BrainTumour/imagesTr" --output "output/labels" --model "output/models"
