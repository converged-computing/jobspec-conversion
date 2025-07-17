#!/bin/bash
#FLUX: --job-name=milky-fork-3822
#FLUX: -t=120
#FLUX: --urgency=16

module load cuda cudnn hdf5 python/3.6.3
source /home/smaslova/pytorch/bin/activate
tensorboard --logdir=./tensorboard_logs/ --host 0.0.0.0 &
