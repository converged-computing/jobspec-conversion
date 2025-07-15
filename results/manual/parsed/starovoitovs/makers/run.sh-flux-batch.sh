#!/bin/bash
#FLUX: --job-name=outstanding-destiny-0146
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --urgency=16

module load Stages/2022 GCC/11.2.0 OpenMPI/4.1.2 Horovod/0.24.2-Python-3.9.6 Nsight-Systems
cd /p/home/jusers/$USER/juwels/projects/makers
srun python fbsde.py --n_paths=262144
