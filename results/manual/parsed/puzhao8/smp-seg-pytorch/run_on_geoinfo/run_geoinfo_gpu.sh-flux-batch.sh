#!/bin/bash
#FLUX: --job-name=phat-cattywampus-8891
#FLUX: --priority=16

echo "start"
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; python3 test_geoinfo_gpu.py
echo "finish"
