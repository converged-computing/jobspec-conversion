#!/bin/bash
#FLUX: --job-name=wobbly-nalgas-1383
#FLUX: --urgency=16

echo "neuralGIF pytorch implementation"
cd /BS/garvita/work/code/neuralgif
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate if-net_10
python trainer.py
