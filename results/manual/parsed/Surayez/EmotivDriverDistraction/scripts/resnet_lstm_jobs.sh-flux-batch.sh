#!/bin/bash
#FLUX: --job-name=ResNet_LSTM
#FLUX: --queue=m3f
#FLUX: -t=72000
#FLUX: --urgency=16

problem=Emotiv266
model=resnet_lstm
cd ..
python3 compare_models.py -p Emotiv266 -c $model -i 5
