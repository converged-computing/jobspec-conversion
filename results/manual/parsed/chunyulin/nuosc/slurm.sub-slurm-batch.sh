#!/bin/bash
#SBATCH --job-name=nuosc
#SBATCH --account=GOV109092
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --partition=gtest
#SBATCH --constraint=ntasks-per-node=4

module purge
module load nvhpc/21.7
NSYS=/work/opt/ohpc/pkg/qchem/nv/nsight-systems-2020.3.1/bin/nsys
OUT=nuosc
srun ${NSYS} profile -o ${OUT} -f true --trace openmp,nvtx,cuda ./nuosc
echo "--- Walltime: ${SECONDS} sec."
