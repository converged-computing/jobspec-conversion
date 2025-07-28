#!/bin/bash
#FLUX: --job-name=dirty-rabbit-5248
#FLUX: -c=2
#FLUX: -t=180
#FLUX: --urgency=16

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
