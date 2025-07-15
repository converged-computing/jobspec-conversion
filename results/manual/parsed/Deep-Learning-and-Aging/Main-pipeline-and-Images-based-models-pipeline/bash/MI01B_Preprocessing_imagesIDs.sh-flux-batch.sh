#!/bin/bash
#FLUX: --job-name=angry-knife-6355
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI01B_Preprocessing_imagesIDs.py && echo "PYTHON SCRIPT COMPLETED"
