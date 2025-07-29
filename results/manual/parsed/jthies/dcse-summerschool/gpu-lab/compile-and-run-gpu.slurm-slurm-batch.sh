#!/bin/bash
#SBATCH --account=education-eemcs-courses-summerschool2023
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=00:05:00
#SBATCH --partition=gpu

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
