#!/bin/bash
#FLUX: --job-name=fugly-malarkey-0567
#FLUX: --queue=priority
#FLUX: -t=2700
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI01B_Preprocessing_imagesIDs.py && echo "PYTHON SCRIPT COMPLETED"
