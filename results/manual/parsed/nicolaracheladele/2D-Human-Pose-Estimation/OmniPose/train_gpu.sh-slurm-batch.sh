#!/bin/bash
#FLUX: --job-name=creamy-mango-9531
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

./OmniPose/run_train.sh
