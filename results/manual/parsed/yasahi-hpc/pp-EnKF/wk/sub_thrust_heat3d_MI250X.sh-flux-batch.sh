#!/bin/bash
#FLUX: --job-name=heat3d-mpi
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='7'
export MPICH_GPU_SUPPORT_ENABLED='1'

module load PrgEnv-amd
module load amd/5.4.3
module load cray-mpich/8.1.26
module load craype-accel-amd-gfx90a
module list
export OMP_NUM_THREADS=7
export MPICH_GPU_SUPPORT_ENABLED=1
srun -N1 -n1 -c7 --ntasks-per-node=1 ../build/mini-apps/heat3d/thrust/heat3d-thrust --nx 512 --ny 512 --nz 512 --nbiter 1000 --freq_diag 0
