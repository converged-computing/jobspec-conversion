#!/bin/bash
#FLUX: --job-name=anxious-peanut-6585
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load 2022r2
module load cuda/11.1.1
module load nvhpc
module load likwid
LAUNCH="srun"
NDIM=10000
NRUNS=100
echo "running on node `hostname`"
nvidia-smi
make gpu
echo "OpenMP offloading"
${LAUNCH} ./matvecprod-offload.x ${NDIM} ${NRUNS}
echo "CuBLAS"
${LAUNCH} ./matvecprod-cublas.x ${NDIM} ${NRUNS}
echo "CUDA, global memory"
${LAUNCH} ./matvecprod-globalmem-simple_um.x ${NDIM} ${NRUNS}
echo "CUDA, shared memory"
${LAUNCH} ./matvecprod-sharedmem-simple_um.x ${NDIM} ${NRUNS}
