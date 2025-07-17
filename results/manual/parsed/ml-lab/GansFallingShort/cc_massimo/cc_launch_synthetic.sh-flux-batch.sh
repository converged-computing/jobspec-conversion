#!/bin/bash
#FLUX: --job-name=lovable-peas-9587
#FLUX: -c=2
#FLUX: -t=180
#FLUX: --urgency=16

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
