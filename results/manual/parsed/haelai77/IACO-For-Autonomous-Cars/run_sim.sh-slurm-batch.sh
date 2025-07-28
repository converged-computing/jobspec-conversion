#!/bin/bash
#FLUX: --job-name=1000_runs
#FLUX: --queue=cpu
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
. ~/initConda.sh
conda activate diss
python -u ./code/main.py -density 2.3 -alpha 0
