#!/bin/bash
#FLUX: --job-name=adorable-buttface-8912
#FLUX: -t=604800
#FLUX: --urgency=16

echo "start"
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; python3 test_geoinfo_gpu.py
echo "finish"
