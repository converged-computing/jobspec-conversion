#!/bin/bash
#FLUX --job-name=spicy-despacito-5671
#FLUX --queue=gpu
#FLUX -t=72000
#FLUX --urgency=16

./OmniPose/run_train.sh
