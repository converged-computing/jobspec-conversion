#!/bin/bash
#FLUX: --job-name=frigid-milkshake-1891
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

./OmniPose/run_train.sh
