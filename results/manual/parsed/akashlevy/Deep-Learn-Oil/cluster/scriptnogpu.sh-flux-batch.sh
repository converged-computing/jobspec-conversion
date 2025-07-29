#!/bin/bash
#FLUX --job-name=goodbye-plant-1254
#FLUX --queue=holyseasgpu
#FLUX -t=3600
#FLUX --urgency=16

python fcn.py
