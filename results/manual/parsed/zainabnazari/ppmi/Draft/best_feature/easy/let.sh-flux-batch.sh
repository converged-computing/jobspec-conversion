#!/bin/bash
#FLUX: --job-name=my_dask_job
#FLUX: -N=3
#FLUX: -c=2
#FLUX: --queue=regular2
#FLUX: -t=2400
#FLUX: --priority=16

module purge
module load gnu8/8.3.0
module load openmpi3/3.1.4
source /home/znazari/.bashrc
conda activate Zainab-env
mpiexec --version
mpiexec -n 16 python  hi.py
