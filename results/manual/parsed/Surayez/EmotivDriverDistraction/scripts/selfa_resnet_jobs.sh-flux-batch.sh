#!/bin/bash
#FLUX: --job-name=SelfA_ResNet
#FLUX: --queue=m3f
#FLUX: -t=72000
#FLUX: --priority=16

problem=Emotiv266
model=SelfA_ResNet
cd ..
python3 compare_models.py -p Emotiv266 -c $model -i 5
