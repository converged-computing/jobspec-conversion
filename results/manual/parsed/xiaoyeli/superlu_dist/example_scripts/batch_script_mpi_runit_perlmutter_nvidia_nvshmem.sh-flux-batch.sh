#!/bin/bash
#FLUX: --job-name=1node
#FLUX: --queue=regular
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export SLURM_CPU_BIND='cores'
export MPICH_GPU_SUPPORT_ENABLED='0'
export CRAY_ACCEL_TARGET='nvidia80'
export LD_LIBRARY_PATH='$NVSHMEM_HOME/lib:$LD_LIBRARY_PATH'
export MAX_BUFFER_SIZE='50000000'
export SUPERLU_BIND_MPI_GPU='1'
export SUPERLU_ACC_OFFLOAD='0 # this can be 0 to do CPU tests on GPU nodes'
export SUPERLU_ACC_SOLVE='1'
export NVSHMEM_USE_GDRCOPY='1'
export NVSHMEM_MPI_SUPPORT='1'
export MPI_HOME='${MPICH_DIR}'
export NVSHMEM_LIBFABRIC_SUPPORT='1'
export LIBFABRIC_HOME='/opt/cray/libfabric/1.15.2.0'
export NVSHMEM_DISABLE_CUDA_VMM='1'
export FI_CXI_OPTIMIZED_MRS='false'
export NVSHMEM_BOOTSTRAP_TWO_STAGE='1'
export NVSHMEM_BOOTSTRAP='MPI'

module load PrgEnv-nvidia 
module load cudatoolkit
module load cray-libsci
module load cmake
module load nvshmem/2.11.0
export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export SLURM_CPU_BIND="cores"
export MPICH_GPU_SUPPORT_ENABLED=0
export CRAY_ACCEL_TARGET=nvidia80
echo MPICH_GPU_SUPPORT_ENABLED=$MPICH_GPU_SUPPORT_ENABLED
export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:$LD_LIBRARY_PATH
export MAX_BUFFER_SIZE=50000000
export SUPERLU_BIND_MPI_GPU=1
export SUPERLU_ACC_OFFLOAD=0 # this can be 0 to do CPU tests on GPU nodes
export SUPERLU_ACC_SOLVE=1
export NVSHMEM_USE_GDRCOPY=1
export NVSHMEM_MPI_SUPPORT=1
export MPI_HOME=${MPICH_DIR}
export NVSHMEM_LIBFABRIC_SUPPORT=1
export LIBFABRIC_HOME=/opt/cray/libfabric/1.15.2.0
export LD_LIBRARY_PATH=$NVSHMEM_HOME/lib:$LD_LIBRARY_PATH
export NVSHMEM_DISABLE_CUDA_VMM=1
export FI_CXI_OPTIMIZED_MRS=false
export NVSHMEM_BOOTSTRAP_TWO_STAGE=1
export NVSHMEM_BOOTSTRAP=MPI
INPUT_DIR=$CFS/m2957/liuyangz/my_research/matrix/
matrix=(s1_mat_0_126936.bin) 
MYDATE=$(date '+%Y-%m-%d-%H-%M')
for MAT in ${matrix[@]}
do
    export NSUP=256
    export NREL=256
    srun -n1  -c128 --cpu_bind=cores -G 1 ./EXAMPLE/pddrive -c 1 -r 1 $INPUT_DIR/$MAT |& tee slu_${MAT}_1node_1x1_OMP${OMP_NUM_THREADS}_${MYDATE}.log
    srun -n2  -c 64 --cpu_bind=cores -G 2 ./EXAMPLE/pddrive -c 1 -r 2 $INPUT_DIR/$MAT |& tee slu_${MAT}_1node_2x1_OMP${OMP_NUM_THREADS}_${MYDATE}.log
    srun -n3  -c 42 --cpu_bind=cores -G 3 ./EXAMPLE/pddrive -c 1 -r 3 $INPUT_DIR/$MAT |& tee slu_${MAT}_1node_3x1_OMP${OMP_NUM_THREADS}_${MYDATE}.log
    srun -n4  -c 32 --cpu_bind=cores -G 4 ./EXAMPLE/pddrive -c 1 -r 4 $INPUT_DIR/$MAT |& tee slu_${MAT}_1node_4x1_OMP${OMP_NUM_THREADS}_${MYDATE}.log
done
