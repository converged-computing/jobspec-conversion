#!/bin/bash
#FLUX: --job-name=sedov_N126_sfc1D_np4
#FLUX: -n=4
#FLUX: -t=1200
#FLUX: --urgency=16

source ~/.bashrc
module load compiler/gnu/10.2
module load devel/cuda/11.4
module load mpi/openmpi/4.1
module load lib/hdf5/1.12.2-gnu-10.2-openmpi-4.1
cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
which mpicc
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/local/lib
nvidia-smi
nvidia-smi -L
mpirun -np 4 bin/runner -n 50 -f sedov/initial_sedov/sedovN126.h5 -C sedov/sedov_N126_sfc1D_np4/config.info -m sedov/sedov_N126_sfc1D_np4/material.cfg
