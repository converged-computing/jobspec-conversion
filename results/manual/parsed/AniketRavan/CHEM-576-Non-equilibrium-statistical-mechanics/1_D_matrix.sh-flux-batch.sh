#!/bin/bash
#FLUX: --job-name=swampy-motorcycle-3234
#FLUX: --priority=16

echo "Loading module"
echo "Loaded module. Running python"
module load Python/3.6.1-IGB-gcc-4.9.4
python 1_D_matrix.py
