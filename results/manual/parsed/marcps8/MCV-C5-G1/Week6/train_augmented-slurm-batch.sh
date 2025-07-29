#!/bin/bash
#FLUX: --job-name=astute-buttface-6765
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python model/augmentation_InceptionResnetV1.py ./data train
