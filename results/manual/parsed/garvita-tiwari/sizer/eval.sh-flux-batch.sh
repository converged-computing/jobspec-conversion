#!/bin/bash
#FLUX: --job-name=stinky-squidward-8684
#FLUX: --urgency=16

echo "canonical pose data for whole body"
cd /BS/garvita/work/code/sizer
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate pytorch3d
python trainer.py
