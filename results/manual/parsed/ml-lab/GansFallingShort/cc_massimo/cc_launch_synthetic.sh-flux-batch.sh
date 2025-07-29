#!/bin/bash
#FLUX --job-name=placid-plant-4335
#FLUX -c=2
#FLUX -t=180
#FLUX --urgency=16

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
