#!/bin/bash
#FLUX: --job-name=fugly-buttface-5287
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH//\/usr\/local\/cuda-12.2\/compat:/}'

module load PrgEnv-gnu
module load cmake
module load cudatoolkit/12.2
module load cray-libsci/23.12.5
module use /global/common/software/nersc/pe/modulefiles/latest
module load nvshmem/2.11.0
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//\/usr\/local\/cuda-12.2\/compat:/}
cmake .. \
  -DCMAKE_C_FLAGS="-O2 -std=c11 -DPRNTlevel=0 -DPROFlevel=0 -DDEBUGlevel=0 -DAdd_" \
  -DCMAKE_CXX_FLAGS="-O2" \
  -DCMAKE_Fortran_FLAGS="-O2" \
  -DCMAKE_CXX_COMPILER=CC \
  -DCMAKE_C_COMPILER=cc \
  -DCMAKE_Fortran_COMPILER=ftn \
  -DXSDK_ENABLE_Fortran=ON \
  -DTPL_ENABLE_INTERNAL_BLASLIB=OFF \
  -DTPL_ENABLE_LAPACKLIB=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DTPL_ENABLE_CUDALIB=ON \
  -DCMAKE_CUDA_FLAGS="-I${NVSHMEM_HOME}/include -I${MPICH_DIR}/include -ccbin=/opt/cray/pe/craype/2.7.30/bin/CC" \
  -DCMAKE_CUDA_ARCHITECTURES=80 \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_INSTALL_LIBDIR=./lib \
  -DCMAKE_BUILD_TYPE=Debug \
  -DTPL_ENABLE_MAGMALIB=ON \
  -DTPL_MAGMA_INCLUDE_DIRS="/global/cfs/cdirs/m2957/lib/magma-2.7.1/include" \
  -DTPL_MAGMA_LIBRARIES="/global/cfs/cdirs/m2957/lib/magma-2.7.1/lib/libmagma.so" \
  -DTPL_BLAS_LIBRARIES=/opt/cray/pe/libsci/23.12.5/GNU/12.3/x86_64/lib/libsci_gnu_123_mp.so \
  -DTPL_LAPACK_LIBRARIES=/opt/cray/pe/libsci/23.12.5/GNU/12.3/x86_64/lib/libsci_gnu_123_mp.so \
  -DTPL_PARMETIS_INCLUDE_DIRS="/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3/include;/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3/metis/include" \
  -DTPL_PARMETIS_LIBRARIES="/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3/build/Linux-x86_64/libparmetis/libparmetis.so;/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3/build/Linux-x86_64/libmetis/libmetis.so" \
  -DTPL_ENABLE_COMBBLASLIB=OFF \
  -DTPL_ENABLE_NVSHMEM=ON \
  -DTPL_NVSHMEM_LIBRARIES="-L${CUDA_HOME}/lib64/stubs/ -lnvidia-ml -L/usr/lib64 -lgdrapi -lstdc++ -L/opt/cray/libfabric/1.15.2.0/lib64 -lfabric -L${NVSHMEM_HOME}/lib -lnvshmem" \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
  -DMPIEXEC_NUMPROC_FLAG=-n \
  -DMPIEXEC_EXECUTABLE=/usr/bin/srun \
  -DMPIEXEC_MAX_NUMPROCS=16
make pddrive -j16
make pddrive3d -j16
make f_pddrive
