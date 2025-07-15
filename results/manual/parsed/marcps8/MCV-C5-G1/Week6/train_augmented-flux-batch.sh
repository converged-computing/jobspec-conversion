#!/bin/bash
#FLUX: --job-name=arid-lemon-3051
#FLUX: --priority=16

python model/augmentation_InceptionResnetV1.py ./data train
