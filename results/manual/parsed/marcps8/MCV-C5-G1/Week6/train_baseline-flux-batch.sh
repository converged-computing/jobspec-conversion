#!/bin/bash
#FLUX: --job-name=eccentric-spoon-9932
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python model/baseline_InceptionResnetV1.py ./data train
