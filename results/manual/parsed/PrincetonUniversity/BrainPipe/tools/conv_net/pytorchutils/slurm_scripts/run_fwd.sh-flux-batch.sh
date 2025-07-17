#!/bin/bash
#FLUX: --job-name=persnickety-citrus-4026
#FLUX: --queue=all
#FLUX: -t=600
#FLUX: --urgency=16

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/2020.11
. activate brainpipe
python run_fwd.py exp2 /tigress/ahoag/cnn/exp2 models/RSUNet.py 12000 --gpus 0 --noeval --tag exp2
