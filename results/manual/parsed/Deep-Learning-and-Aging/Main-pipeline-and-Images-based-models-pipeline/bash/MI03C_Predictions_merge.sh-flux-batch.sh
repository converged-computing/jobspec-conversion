#!/bin/bash
#FLUX: --job-name=reclusive-spoon-3254
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source ~/python_3.6.0/bin/activate
python -u ../scripts/MI03C_Predictions_merge.py $1 $2 && echo "PYTHON SCRIPT COMPLETED"
