#!/bin/bash
#FLUX: --job-name=goodbye-peanut-4626
#FLUX: -n=12
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module use /data/cigi/common/cigi-modules
module add GNU610
module add GPU
module load anaconda2
python -u run.py $1 $2 15
