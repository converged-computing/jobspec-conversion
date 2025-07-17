#!/bin/bash
#FLUX: --job-name=oss-2-ee
#FLUX: -n=2
#FLUX: -c=8
#FLUX: -t=900
#FLUX: --urgency=16

export OSS2EE_MPI_LIB_DIR='/apps/INTEL/2017.2-028/impi/2017.2.191/lib64'
export OSS2EE_MPI_INC_DIR='/apps/INTEL/2017.2-028/impi/2017.2.191/include64'
export OSS2EE_MKL_LIB_DIR='/apps/INTEL/2017.2-028/mkl/lib/intel64/'
export OSS2EE_MKL_INC_DIR='/apps/INTEL/2017.2-028/mkl/include'
export OSS2EE_ATL_LIB_DIR='/gpfs/apps/NVIDIA/ATLAS/3.9.51/lib'
export OSS2EE_ATL_INC_DIR='/gpfs/apps/NVIDIA/ATLAS/3.9.51/include/'
export OSS2EE_TAMPI_LIB_DIR='$TAMPI_HOME/lib'
export OSS2EE_TAMPI_INC_DIR='$TAMPI_HOME/include'
export OSS2EE_MPICC_COMMAND='mpiicc'
export OSS2EE_MPICXX_COMMAND='mpiicpc'
export OSS2EE_MPIRUN_COMMAND='srun --cpu_bind=cores'

module purge
module load intel/2017.2
module load gcc/6.2.0
module load impi/2017.1
module load mkl/2017.2
module load bsc/current
module load ompss-2/2019.11.2
module load tampi/1.0.1
module load extrae
module load paraver
cat > $OSS2EE_CONFIG_DIR/job-sched-1n << EOF
EOF
cat > $OSS2EE_CONFIG_DIR/job-sched-mn << EOF
EOF
export OSS2EE_MPI_LIB_DIR=/apps/INTEL/2017.2-028/impi/2017.2.191/lib64
export OSS2EE_MPI_INC_DIR=/apps/INTEL/2017.2-028/impi/2017.2.191/include64
export OSS2EE_MKL_LIB_DIR=/apps/INTEL/2017.2-028/mkl/lib/intel64/
export OSS2EE_MKL_INC_DIR=/apps/INTEL/2017.2-028/mkl/include
export OSS2EE_ATL_LIB_DIR=/gpfs/apps/NVIDIA/ATLAS/3.9.51/lib
export OSS2EE_ATL_INC_DIR=/gpfs/apps/NVIDIA/ATLAS/3.9.51/include/
export OSS2EE_TAMPI_LIB_DIR=$TAMPI_HOME/lib
export OSS2EE_TAMPI_INC_DIR=$TAMPI_HOME/include
export OSS2EE_MPICC_COMMAND="mpiicc"
export OSS2EE_MPICXX_COMMAND="mpiicpc"
export OSS2EE_MPIRUN_COMMAND="srun --cpu_bind=cores"
unset NANOS6_CONFIG_OVERRIDE
