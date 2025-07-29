#!/bin/bash
#SBATCH --output=new-smpv-a100.o%j
#SBATCH --error=new-smpv-a100.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00

shopt -s extglob
ROOT=/home/cwpears/repos/pr-merge
source $HOME/spack-caraway/spack/share/spack/setup-env.sh
spack load cuda
module load cmake
date
echo "reals_med"
"$ROOT"/build-caraway-a100/kokkos-kernels/perf_test/sparse/sparse_kk_spmv_merge \
/home/projects/cwpears/suitesparse/reals_med/*.mtx
date
