#!/bin/bash
#FLUX: --job-name=tart-itch-2618
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python model/augmentation_InceptionResnetV1.py ./data train
