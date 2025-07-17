#!/bin/bash
#FLUX: --job-name=langevin_overdamped
#FLUX: -n=4
#FLUX: --queue=normal
#FLUX: --urgency=16

echo "Loading module"
echo "Loaded module. Running python"
module load Python/3.6.1-IGB-gcc-4.9.4
python 1_D_matrix.py
