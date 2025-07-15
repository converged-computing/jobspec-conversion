#!/bin/bash
#FLUX: --job-name=global_analysis
#FLUX: -c=12
#FLUX: --queue=dgx
#FLUX: -t=87825
#FLUX: --urgency=16

source /home/jdonnelly/protoPNet/bin/activate
MODELDIR='saved_models/resnet50/datasets/CUB_200_2011/train/001/'
MODELNAME='30push0.8564.pth'
srun python3 global_analysis.py -gpuid='0' -modeldir $MODELDIR -model $MODELNAME
