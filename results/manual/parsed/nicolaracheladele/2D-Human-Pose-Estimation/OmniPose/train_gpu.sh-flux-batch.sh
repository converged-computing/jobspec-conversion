#!/bin/bash
#FLUX --job-name=boopy-underoos-5742
#FLUX --queue=gpu
#FLUX -t=72000
#FLUX --urgency=16

./OmniPose/run_train.sh
