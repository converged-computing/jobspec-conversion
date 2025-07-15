#!/bin/bash
#FLUX: --job-name=purple-pedo-5838
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --priority=16

./OmniPose/run_train.sh
