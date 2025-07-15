#!/bin/bash
#FLUX: --job-name=goodbye-hippo-8724
#FLUX: --priority=16

echo "Starting job $SLURM_JOB_ID"
cat job.slurm
case=${CASE:-"cpu"}
echo $case
. /data/spack/share/spack/setup-env.sh
spack load intel-oneapi-compilers@2024
spack load intel-oneapi-mkl
spack load cmake@3.27.9
spack load cuda@12.2.1
./build/CUDA_GEMM $case
