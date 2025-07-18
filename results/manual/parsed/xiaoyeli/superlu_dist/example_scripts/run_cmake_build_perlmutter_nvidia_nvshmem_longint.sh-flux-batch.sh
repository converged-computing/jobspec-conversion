#!/bin/bash
#FLUX: --job-name=loopy-omelette-6410
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH//\/usr\/local\/cuda-12.2\/compat:/}'

module load cmake
module load PrgEnv-nvidia
module load cudatoolkit
module load cray-libsci
module load nvshmem/2.11.0
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//\/usr\/local\/cuda-12.2\/compat:/}
cmake .. \
  -DCMAKE_C_FLAGS="  -std=c11 -DPRNTlevel=1 -DPROFlevel=0 -DDEBUGlevel=0 -DAdd_ -I${NVSHMEM_HOME}/include" \
  -DCMAKE_CXX_COMPILER=CC \
  -DCMAKE_C_COMPILER=cc \
  -DCMAKE_Fortran_COMPILER=ftn \
  -DXSDK_ENABLE_Fortran=ON \
  -DTPL_ENABLE_INTERNAL_BLASLIB=OFF \
  -DTPL_ENABLE_LAPACKLIB=ON \
  -DBUILD_SHARED_LIBS=OFF \
  -DTPL_ENABLE_CUDALIB=ON \
  -DCMAKE_CUDA_FLAGS="-I${NVSHMEM_HOME}/include -I${MPICH_DIR}/include -ccbin=/opt/cray/pe/craype/2.7.30/bin/CC" \
  -DCMAKE_CUDA_ARCHITECTURES=80 \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_INSTALL_LIBDIR=./lib \
  -DCMAKE_BUILD_TYPE=Debug \
  -DTPL_BLAS_LIBRARIES=/opt/cray/pe/libsci/23.12.5/NVIDIA/23.3/x86_64/lib/libsci_nvidia_mp.so \
  -DTPL_LAPACK_LIBRARIES=/opt/cray/pe/libsci/23.12.5/NVIDIA/23.3/x86_64/lib/libsci_nvidia_mp.so \
  -DTPL_PARMETIS_INCLUDE_DIRS="/global/cfs/cdirs/m2957/liuyangz/my_software/parmetis-4.0.3-nvidia-longint/include;/global/cfs/cdirs/m2957/liuyangz/my_software/parmetis-4.0.3-nvidia-longint/metis/include" \
  -DTPL_PARMETIS_LIBRARIES="/global/cfs/cdirs/m2957/liuyangz/my_software/parmetis-4.0.3-nvidia-longint/build/Linux-x86_64/libparmetis/libparmetis.so;/global/cfs/cdirs/m2957/liuyangz/my_software/parmetis-4.0.3-nvidia-longint/build/Linux-x86_64/libmetis/libmetis.so" \
  -DTPL_ENABLE_COMBBLASLIB=OFF \
  -DTPL_ENABLE_NVSHMEM=OFF \
  -DTPL_NVSHMEM_LIBRARIES="-L${CUDA_HOME}/lib64/stubs/ -lnvidia-ml -L/usr/lib64 -lgdrapi -lstdc++ -L/opt/cray/libfabric/1.15.2.0/lib64 -lfabric -L${NVSHMEM_HOME}/lib -lnvshmem" \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
  -DMPIEXEC_NUMPROC_FLAG=-n \
  -DMPIEXEC_EXECUTABLE=/usr/bin/srun \
  -DMPIEXEC_MAX_NUMPROCS=16 \
  -Denable_complex16=ON \
  -DXSDK_INDEX_SIZE=64 \
  -Denable_single=ON
make pddrive -j16
make pddrive3d -j16
make pzdrive -j16
make pzdrive3d -j16
make psdrive -j16
make psdrive3d -j16
