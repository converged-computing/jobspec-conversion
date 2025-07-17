#!/bin/bash
#FLUX: --job-name=spicy-underoos-5368
#FLUX: --queue=priority
#FLUX: --urgency=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI09E_GWAS_postprocessing.py $1 && echo "PYTHON SCRIPT COMPLETED"
