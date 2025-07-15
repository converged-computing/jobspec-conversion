#!/bin/bash
#FLUX: --job-name=swampy-caramel-7846
#FLUX: --priority=16

echo "canonical pose data for whole body"
cd /BS/garvita/work/code/sizer
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate pytorch3d
python trainer.py
