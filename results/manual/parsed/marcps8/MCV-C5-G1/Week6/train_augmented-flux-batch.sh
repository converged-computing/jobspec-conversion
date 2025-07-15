#!/bin/bash
#FLUX: --job-name=tart-omelette-9863
#FLUX: --urgency=16

python model/augmentation_InceptionResnetV1.py ./data train
