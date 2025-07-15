#!/bin/bash
#FLUX: --job-name=crusty-parrot-5023
#FLUX: --priority=16

echo "neuralGIF pytorch implementation"
cd /BS/garvita/work/code/neuralgif
source /BS/garvita/static00/software/miniconda3/etc/profile.d/conda.sh
conda activate if-net_10
python trainer.py
