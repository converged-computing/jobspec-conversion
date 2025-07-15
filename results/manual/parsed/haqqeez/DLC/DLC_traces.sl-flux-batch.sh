#!/bin/bash
#FLUX: --job-name=TASKNAME
#FLUX: -t=890
#FLUX: --urgency=16

export DLClight='True'

module load scipy-stack/2021a
module load python/3.8
source ENVPATH
export DLClight=True
echo "TESTING GPU"
nvidia-smi
echo "RUNNING NOW"
python DLC_traces.py
