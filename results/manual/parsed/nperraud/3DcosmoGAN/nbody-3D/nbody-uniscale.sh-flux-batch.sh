#!/bin/bash
#FLUX: --job-name=bricky-cupcake-1367
#FLUX: -t=86340
#FLUX: --priority=16

module load daint-gpu
module load cray-python
module load TensorFlow/1.12.0-CrayGNU-18.08-cuda-9.1-python3
source /users/nperraud/upgan/bin/activate
srun python nbody-uniscale.py
