#!/bin/bash
#FLUX: --job-name=crunchy-lemon-7929
#FLUX: --urgency=16

export PATH='/vol/bitbucket/${USER}/cbm_venv/bin/:$PATH'
export PYTHONPATH='${PYTHONPATH}:/vol/bitbucket/${USER}/roko-for-charlize'

export PATH=/vol/bitbucket/${USER}/cbm_venv/bin/:$PATH
source activate
export PYTHONPATH=${PYTHONPATH}:/vol/bitbucket/${USER}/roko-for-charlize
source /vol/cuda/11.2.1-cudnn8.1.0.77/setup.sh
TERM=vt100 # or TERM=xterm
/usr/bin/nvidia-smi
rm -f labels_100.pkl data.npy
cd /vol/bitbucket/${USER}/roko-for-charlize
for i in {1..5}
do
  # python img_classifier.py --fold ${i}
  # python img_classifier_upsample.py --fold ${i}
  python img_classifier_downsample.py --fold ${i}
  # python transformer_experiment.py --fold ${i}
done
uptime
