#!/bin/bash
#FLUX: --job-name=visualize_segmentations
#FLUX: -c=8
#FLUX: -t=960
#FLUX: --urgency=16

module purge
module load cuda/11.6.2
python -u visualize.py
echo "Done"
