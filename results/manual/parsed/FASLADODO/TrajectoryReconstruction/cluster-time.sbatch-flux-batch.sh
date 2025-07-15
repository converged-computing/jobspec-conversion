#!/bin/bash
#FLUX: --job-name=slurm_%j
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load python3/intel/3.6.3
source ~/bigdata/bdpy/bin/activate
python LinearInterpolationTime.py  > printTime.txt
