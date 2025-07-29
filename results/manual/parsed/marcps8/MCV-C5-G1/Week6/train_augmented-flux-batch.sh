#!/bin/bash
#FLUX --job-name=misunderstood-muffin-5095
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python model/augmentation_InceptionResnetV1.py ./data train
