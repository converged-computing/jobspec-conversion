#!/bin/bash
#FLUX: --job-name=Inversion
#FLUX: -N=40
#FLUX: -t=7200
#FLUX: --urgency=16

export MPLCONFIGDIR='${LUSTRE}/.matplotlib'
export OMP_NUM_THREADS='1'
export MPICH_GPU_SUPPORT_ENABLED='0'

module purge
module load PrgEnv-cray amd-mixed cray-mpich craype-accel-amd-gfx90a
module load core-personal hdf5-personal
module unload darshan-runtime
export MPLCONFIGDIR=${LUSTRE}/.matplotlib
export OMP_NUM_THREADS=1
export MPICH_GPU_SUPPORT_ENABLED=0
source ~/miniconda3/bin/activate gf
python -c "from nnodes import root; root.run()"
