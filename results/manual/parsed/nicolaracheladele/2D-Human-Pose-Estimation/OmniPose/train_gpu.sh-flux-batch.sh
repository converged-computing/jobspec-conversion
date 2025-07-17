#!/bin/bash
#FLUX: --job-name=crusty-staircase-3214
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

./OmniPose/run_train.sh
