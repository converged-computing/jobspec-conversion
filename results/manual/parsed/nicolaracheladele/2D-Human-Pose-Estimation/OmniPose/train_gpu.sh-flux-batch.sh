#!/bin/bash
#FLUX: --job-name=milky-arm-6117
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

./OmniPose/run_train.sh
