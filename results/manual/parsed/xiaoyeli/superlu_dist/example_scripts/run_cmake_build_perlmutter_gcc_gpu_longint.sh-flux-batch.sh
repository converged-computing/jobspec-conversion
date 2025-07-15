#!/bin/bash
#FLUX: --job-name=quirky-latke-4390
#FLUX: --priority=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH//\/usr\/local\/cuda-11.7\/compat:/}'

module load PrgEnv-gnu
module load gcc/11.2.0
module load cmake/3.22.0
module load cudatoolkit/11.7
module load cray-libsci/22.11.1.2
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//\/usr\/local\/cuda-11.5\/compat:/}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//\/usr\/local\/cuda-11.7\/compat:/}
cmake .. \
  -DCMAKE_C_FLAGS="-std=c11 -DPRNTlevel=0 -DPROFlevel=0 -DDEBUGlevel=0 -DAdd_" \
  -DCMAKE_CXX_COMPILER=CC \
  -DCMAKE_C_COMPILER=cc \
  -DCMAKE_Fortran_COMPILER=ftn \
  -DXSDK_ENABLE_Fortran=ON \
  -DTPL_ENABLE_INTERNAL_BLASLIB=OFF \
  -DTPL_ENABLE_LAPACKLIB=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DXSDK_INDEX_SIZE=64 \
  -DTPL_ENABLE_CUDALIB=ON \
  -DCMAKE_CUDA_FLAGS="-I${MPICH_DIR}/include -ccbin=/opt/cray/pe/craype/2.7.19/bin/CC" \
  -DCMAKE_CUDA_ARCHITECTURES=80 \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_INSTALL_LIBDIR=./lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DTPL_BLAS_LIBRARIES=/opt/cray/pe/libsci/22.11.1.2/GNU/9.1/x86_64/lib/libsci_gnu_82_mp.so \
  -DTPL_LAPACK_LIBRARIES=/opt/cray/pe/libsci/22.11.1.2/GNU/9.1/x86_64/lib/libsci_gnu_82_mp.so \
  -DTPL_PARMETIS_INCLUDE_DIRS="/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3-longint/include;/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3-longint/metis/include" \
  -DTPL_PARMETIS_LIBRARIES="/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3-longint/build/Linux-x86_64/libparmetis/libparmetis.so;/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/parmetis-4.0.3-longint/build/Linux-x86_64/libmetis/libmetis.so" \
  -DTPL_ENABLE_COMBBLASLIB=OFF \
  -DTPL_ENABLE_NVSHMEM=OFF \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
  -DMPIEXEC_NUMPROC_FLAG=-n \
  -DMPIEXEC_EXECUTABLE=/usr/bin/srun \
  -DMPIEXEC_MAX_NUMPROCS=16
make pddrive -j16
make pddrive3d -j16
make f_pddrive
