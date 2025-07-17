#!/bin/bash
#FLUX: --job-name=setup
#FLUX: --queue=gpuA100
#FLUX: -t=7200
#FLUX: --urgency=16

uenv verbose cuda-11.4 cudnn-11.4-8.2.4
python3 -m pip install -r requirements.txt --user
