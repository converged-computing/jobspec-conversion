#!/bin/bash
#FLUX: --job-name=preprocess_smooth
#FLUX: --queue=gpu
#FLUX: -t=480
#FLUX: --urgency=16

cd ../models
python  -u decuda_model.py
