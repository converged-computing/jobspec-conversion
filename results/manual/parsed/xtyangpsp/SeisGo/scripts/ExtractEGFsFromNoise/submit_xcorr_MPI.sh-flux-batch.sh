#!/bin/bash
#FLUX: --job-name=blue-blackbean-5558
#FLUX: --priority=16

module load rcac
module use /depot/xtyang/etc/modules
module load conda-env/seisgo-py3.7.6
mpirun -n $SLURM_NTASKS python 2_xcorr_MPI.py
