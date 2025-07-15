#!/bin/bash
#FLUX: --job-name=stanky-car-9178
#FLUX: -c=2
#FLUX: -t=180
#FLUX: --urgency=16

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
