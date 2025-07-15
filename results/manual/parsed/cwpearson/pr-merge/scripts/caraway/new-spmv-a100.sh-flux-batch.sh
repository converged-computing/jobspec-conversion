#!/bin/bash
#FLUX: --job-name=adorable-milkshake-5771
#FLUX: -t=10800
#FLUX: --priority=16

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
