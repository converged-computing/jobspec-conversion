#!/bin/bash
#FLUX --job-name=blank-knife-5142
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python model/baseline_InceptionResnetV1.py ./data train
