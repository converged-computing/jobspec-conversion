#!/bin/bash
#FLUX: --job-name=frigid-toaster-8443
#FLUX: --urgency=16

module load anaconda
source activate tensorflow
python run_mapEnv.py
