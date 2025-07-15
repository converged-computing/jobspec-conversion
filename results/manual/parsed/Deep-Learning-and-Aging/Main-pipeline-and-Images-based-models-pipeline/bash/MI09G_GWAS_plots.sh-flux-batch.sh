#!/bin/bash
#FLUX: --job-name=buttery-platanos-0871
#FLUX: --priority=16

set -e
module load gcc/6.2.0
module load python/3.6.0
source /home/al311/python_3.6.0/bin/activate
python -u ../scripts/MI09G_GWAS_plots.py $1 && echo "PYTHON SCRIPT COMPLETED"
