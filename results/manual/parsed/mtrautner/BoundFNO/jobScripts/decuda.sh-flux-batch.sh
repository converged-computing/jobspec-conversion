#!/bin/bash
#FLUX: --job-name=swampy-puppy-2546
#FLUX: --queue=gpu
#FLUX: -t=480
#FLUX: --urgency=16

cd ../models
python  -u decuda_model.py
