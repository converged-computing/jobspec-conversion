#!/bin/bash
#FLUX: --job-name=chocolate-house-7640
#FLUX: --queue=mic
#FLUX: -t=86400
#FLUX: --priority=16

export BLAS_VERSION='/usr/local/intel/ClusterStudioXE_2013/composer_xe_2013_sp1.2.144/mkl/lib/intel64/libmkl_rt.so'
export LAPACK_VERSION='/usr/local/intel/ClusterStudioXE_2013/composer_xe_2013_sp1.2.144/mkl/lib/intel64/libmkl_rt.so'
export MKL_MIC_MAX_MEMORY='16G'
export MKL_MIC_ENABLE='1'
export OFFLOAD_REPORT='2'

setpkgs -a matlab
setpkgs -a intel_cluster_studio_compiler
export BLAS_VERSION=/usr/local/intel/ClusterStudioXE_2013/composer_xe_2013_sp1.2.144/mkl/lib/intel64/libmkl_rt.so
export LAPACK_VERSION=/usr/local/intel/ClusterStudioXE_2013/composer_xe_2013_sp1.2.144/mkl/lib/intel64/libmkl_rt.so
export MKL_MIC_MAX_MEMORY=16G
export MKL_MIC_ENABLE=1
export OFFLOAD_REPORT=2
matlab -nodisplay -nosplash < matrix.m
