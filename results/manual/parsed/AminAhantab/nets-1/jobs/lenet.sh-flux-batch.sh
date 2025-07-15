#!/bin/bash
#FLUX: --job-name=nets_lenet
#FLUX: --queue=gpu
#FLUX: --priority=16

set -euxo pipefail
module load anaconda3/2021.05-gcc-10.3.0
PYTHON_BIN="/scratch/users/k1502897/conda/nets/bin/python"
$PYTHON_BIN -m imp_vs_nets.py
echo "Job finished successfully"
