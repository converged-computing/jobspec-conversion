#!/bin/bash
#FLUX: --job-name=WISDM
#FLUX: -c=16
#FLUX: -t=3600
#FLUX: --urgency=16

pwd; hostname; date
echo "Running Job"
source /home/student17/venv/bin/activate
python3 train_tf.py
deactivate
echo
date
