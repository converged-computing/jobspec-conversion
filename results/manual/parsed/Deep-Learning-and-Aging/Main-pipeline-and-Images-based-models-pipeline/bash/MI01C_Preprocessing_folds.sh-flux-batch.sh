#!/bin/bash
#FLUX: --job-name=blue-butter-2367
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI01C_Preprocessing_folds.py $1 $2 && echo "PYTHON SCRIPT COMPLETED"
