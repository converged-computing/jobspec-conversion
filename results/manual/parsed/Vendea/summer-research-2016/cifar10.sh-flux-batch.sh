#!/bin/bash
#FLUX: --job-name=hanky-cupcake-2331
#FLUX: -n=20
#FLUX: --urgency=16

. ~/.profile
module load gcc/6.1.0
module load openmpi/1.10.2
module load cuDNN/v4.0
module load cuda/7.5.18
unsetenv PYTHONHOME
. ~/.python/python/bin/activate
mpirun cifar10/LBFGS.py
