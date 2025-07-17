#!/bin/bash
#FLUX: --job-name=myMPI
#FLUX: -n=64
#FLUX: --queue=largemem512GB
#FLUX: -t=36000
#FLUX: --urgency=16

export CC='icc'
export CXX='icpc'
export HMLP_USE_BLAS='true'
export MKLROOT='${MKLROOT}'
export OPENBLASROOT='${OPENBLASROOT}'
export NETLIBROOT='${NETLIBROOT}'
export OMP_NUM_THREADS='1'
export HMLP_ARTIFACT_PATH='sc18gofmm'
export HMLP_GPU_ARCH_MAJOR='gpu'
export HMLP_GPU_ARCH_MINOR='kepler'
export HMLP_ARCH_MAJOR='x86_64'
export HMLP_ARCH_MINOR='haswell'
export QSMLROOT='/Users/chenhan/Documents/Projects/qsml/aarch64-linux-android'
export HMLP_USE_MPI='true'
export HMLP_USE_CUDA='false'
export HMLP_CUDA_DIR='$TACC_CUDA_DIR'
export HMLP_USE_MAGMA='false'
export HMLP_MAGMA_DIR='/users/chenhan/Projects/magma-2.2.0'
export HMLP_ANALYSIS_DATA='false'
export HMLP_BUILD_SANDBOX='true'
export OMP_NESTED='false'
export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export I_MPI_PIN='on'
export I_MPI_PIN_MODE='pm'
export I_MPI_PIN_RESPECT_CPUSET='on'
export I_MPI_PIN_RESPECT_HCA='on'
export I_MPI_PIN_CELL='unit'
export I_MPI_PIN_DOMAIN='auto:compact'
export I_MPI_PIN_ORDER='compact'
export KS_JC_NT='1'
export KS_PC_NT='1'
export KS_IC_NT='1'
export KS_JR_NT='1'
export HMLP_DIR='$PWD'
export DYLD_LIBRARY_PATH='${DYLD_LIBRARY_PATH}:${OPENBLASROOT}/:${OPENBLASROOT}/lib/'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${OPENBLASROOT}/:${OPENBLASROOT}/lib/'
export HMLP_GPU_ARCH='$HMLP_GPU_ARCH_MAJOR/$HMLP_GPU_ARCH_MINOR'
export HMLP_ARCH='$HMLP_ARCH_MAJOR/$HMLP_ARCH_MINOR'

module load TACC
module load intel
module load python
export CC=icc
export CXX=icpc
export HMLP_USE_BLAS=true
export MKLROOT=${MKLROOT}
export OPENBLASROOT=${OPENBLASROOT}
export NETLIBROOT=${NETLIBROOT}
export OMP_NUM_THREADS=1
export HMLP_ARTIFACT_PATH=sc18gofmm
export HMLP_GPU_ARCH_MAJOR=gpu
export HMLP_GPU_ARCH_MINOR=kepler
export HMLP_ARCH_MAJOR=x86_64
export HMLP_ARCH_MINOR=haswell
export QSMLROOT=/Users/chenhan/Documents/Projects/qsml/aarch64-linux-android
export HMLP_USE_MPI=true
export HMLP_USE_CUDA=false
export HMLP_CUDA_DIR=$TACC_CUDA_DIR
export HMLP_USE_MAGMA=false
export HMLP_MAGMA_DIR=/users/chenhan/Projects/magma-2.2.0
export HMLP_ANALYSIS_DATA=false
export HMLP_BUILD_SANDBOX=true
export OMP_NESTED=false
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export I_MPI_PIN=on
export I_MPI_PIN_MODE=pm
export I_MPI_PIN_RESPECT_CPUSET=on
export I_MPI_PIN_RESPECT_HCA=on
export I_MPI_PIN_CELL=unit
export I_MPI_PIN_DOMAIN=auto:compact
export I_MPI_PIN_ORDER=compact
export KS_JC_NT=1
export KS_PC_NT=1
export KS_IC_NT=1
export KS_JR_NT=1
echo "===================================================================="
echo "Notice: HMLP and CMAKE use variables CC and CXX to decide compilers."
echo "        If the following messages pop out:"
echo ""
echo "            Variable CC  is unset (REQUIRED) or"
echo "            Variable CXX is unset (REQUIRED),"
echo ""
echo "        then you must first export these two variables."
echo "===================================================================="
if [ -z ${CC+x} ]; 
then echo "Variable CC  is unset (REQUIRED)"; 
else echo "Variable CC  is set to '$CC'";
fi
if [ -z ${CXX+x} ]; 
then echo "Variable CXX is unset (REQUIRED)"; 
else echo "Variable CXX is set to '$CXX'";
fi
echo "===================================================================="
echo ""
echo "===================================================================="
echo "Notice: HMLP and CMAKE use variables MKLROOT to find Intel MKL."
echo "        If you are using intel compile and seeing the following:"
echo ""
echo "            Variable MKLROOT is unset (REQUIRED by intel compilers)"
echo ""
echo "        then you must first export MKLROOT=/path_to_mkl..."
echo "===================================================================="
if [ -z ${MKLROOT+x} ]; 
then echo "Variable MKLROOT is unset (REQUIRED by intel compilers)"; 
else echo "Variable MKLROOT is set to '$MKLROOT'";
fi
echo "===================================================================="
echo ""
echo "===================================================================="
echo "Notice: HMLP and CMAKE use variables OPENBLASROOT to find OpenBLAS."
echo "        If you are using intel compile and seeing the following:"
echo ""
echo "            Variable OPENBLASROOT is unset (REQUIRED by GNU compilers)"
echo ""
echo "        then you must first export OPENBLASROOT=/path_to_OpenBLAS..."
echo "===================================================================="
if [ -z ${OPENBLASROOT+x} ]; 
then echo "Variable OPENBLASROOT is unset (REQUIRED by GNU compilers)"; 
else echo "Variable OPENBLASROOT is set to '$OPENBLASROOT'";
fi
echo "===================================================================="
echo ""
export HMLP_DIR=$PWD
echo "HMLP_DIR = $HMLP_DIR"
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${HMLP_DIR}/build/lib/
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${MKLROOT}/lib/
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${OPENBLASROOT}/:${OPENBLASROOT}/lib/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HMLP_DIR}/build/lib/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MKLROOT}/lib/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${OPENBLASROOT}/:${OPENBLASROOT}/lib/
export HMLP_GPU_ARCH=$HMLP_GPU_ARCH_MAJOR/$HMLP_GPU_ARCH_MINOR
export HMLP_ARCH=$HMLP_ARCH_MAJOR/$HMLP_ARCH_MINOR
echo "HMLP_GPU_ARCH = $HMLP_GPU_ARCH"
echo "HMLP_ARCH = $HMLP_ARCH"
echo "HMLP_USE_BLAS = $HMLP_USE_BLAS"
echo "QSMLROOT = $QSMLROOT"
echo "HMLP_USE_MPI = $HMLP_USE_MPI"
echo "HMLP_USE_CUDA = $HMLP_USE_CUDA"
echo "HMLP_CUDA_DIR = $HMLP_CUDA_DIR"
echo "HMLP_USE_MAGMA = $HMLP_USE_MAGMA"
echo "HMLP_MAGMA_DIR = $HMLP_MAGMA_DIR"
echo "HMLP_ANALYSIS_DATA = $HMLP_ANALYSIS_DATA"
echo "OMP_PROC_BIND = $OMP_PROC_BIND"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"
echo "OMP_PLACES = $OMP_PLACES"
echo "KS_JC_NT = $KS_JC_NT"
echo "KS_IC_NT = $KS_IC_NT"
echo "KS_JR_NT = $KS_JR_NT"
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 1 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 2 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 4 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 8 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 16 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin/mpiexec -np 32 /home1/05820/xychen/xychen/dbscan/build/test/testDistributedBoruvka 1000000
