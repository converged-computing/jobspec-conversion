#!/bin/bash
#FLUX: --job-name=phat-lamp-0634
#FLUX: -c=2
#FLUX: -t=180
#FLUX: --urgency=16

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
