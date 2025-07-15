#!/bin/bash
#FLUX: --job-name=ml-xas-qm9
#FLUX: --urgency=16

module load gcc/8.3.0
module load openmpi/4.0.2-gcc-8.3.0-cuda10.1
module load pytorch/1.5.1
module load cuda/10.2
source env/bin/activate
which python3
python3 02_qm9_train.py "$@"
