#!/bin/bash
#FLUX: --job-name=confused-underoos-3555
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export MPICH_GPU_SUPPORT_ENABLED='1'
export CRAY_ACCEL_TARGET='nvidia80'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=64
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load python/3.9-anaconda-2021.11
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
module load gpu/1.0
module load craype-accel-nvidia80
export MPICH_GPU_SUPPORT_ENABLED=1
export CRAY_ACCEL_TARGET=nvidia80
module load cudatoolkit
srun -n 5 ./build/release/tools/mpi-greedimm -i /global/cfs/cdirs/m1641/network-data/Binaries/github_IC_binary.txt --streaming-gpu-workers 4 -w -k 100 -p -d IC -e 0.13 -o /global/homes/r/reetb/cuda/results/jobs/github/m5_github_IC.json --run-streaming=true --epsilon-2=0.077 --reload-binary -u
