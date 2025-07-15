#!/bin/bash
#FLUX: --job-name=crusty-cupcake-3836
#FLUX: --urgency=16

export MKLROOT='/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64'

module purge
module load cgpu
module load cuda
module load nvhpc
module load openmpi
module load cmake
export MKLROOT=/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64
NVSHMEM_HOME=/global/cfs/cdirs/m2956/nanding/software/nvshmem_src_2.8.0-3-cori/build/
cmake .. \
  -DCMAKE_C_FLAGS="  -std=c11 -DPRNTlevel=0 -DPROFlevel=0 -DDEBUGlevel=0 -DAdd_ -I${NVSHMEM_HOME}/include" \
  -DCMAKE_CXX_COMPILER=mpic++\
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_Fortran_COMPILER=mpif90 \
  -DXSDK_ENABLE_Fortran=ON \
  -DTPL_ENABLE_INTERNAL_BLASLIB=OFF \
  -DTPL_ENABLE_LAPACKLIB=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DTPL_ENABLE_CUDALIB=ON \
  -DCMAKE_CUDA_FLAGS="-I${NVSHMEM_HOME}/include  -I${CUDA_ROOT}/include -I${OPENMPI_DIR}/include" \
  -DCMAKE_CUDA_ARCHITECTURES=70 \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_INSTALL_LIBDIR=./lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DTPL_BLAS_LIBRARIES="${MKLROOT}/lib/intel64/libmkl_gf_lp64.so;${MKLROOT}/lib/intel64/libmkl_gnu_thread.so;${MKLROOT}/lib/intel64/libmkl_core.so;${MKLROOT}/lib/intel64/libmkl_def.so;${MKLROOT}/lib/intel64/libmkl_avx.so" \
  -DTPL_LAPACK_LIBRARIES="${MKLROOT}/lib/intel64/libmkl_gf_lp64.so;${MKLROOT}/lib/intel64/libmkl_gnu_thread.so;${MKLROOT}/lib/intel64/libmkl_core.so;${MKLROOT}/lib/intel64/libmkl_def.so;${MKLROOT}/lib/intel64/libmkl_avx.so" \
  -DTPL_PARMETIS_LIBRARIES="/global/cfs/cdirs/m2956/nanding/software/parmetis-4.0.3-corigpu/build/Linux-x86_64/libparmetis/libparmetis.so;/global/cfs/cdirs/m2956/nanding/software/parmetis-4.0.3-corigpu/build/Linux-x86_64/libmetis/libmetis.so" \
  -DTPL_PARMETIS_INCLUDE_DIRS="/global/cfs/cdirs/m2956/nanding/software/parmetis-4.0.3-corigpu/include;/global/cfs/cdirs/m2956/nanding/software/parmetis-4.0.3-corigpu/metis/include" \
  -DTPL_ENABLE_COMBBLASLIB=OFF \
  -DTPL_ENABLE_NVSHMEM=ON \
  -DTPL_NVSHMEM_LIBRARIES="-L${CUDA_HOME}/lib64/stubs/ -lnvidia-ml -lstdc++ -L${NVSHMEM_HOME}/lib -lnvshmem" \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
  -DMPIEXEC_NUMPROC_FLAG=-n \
  -DMPIEXEC_EXECUTABLE=/usr/bin/srun \
  -DMPIEXEC_MAX_NUMPROCS=16
