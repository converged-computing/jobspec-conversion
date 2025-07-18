#!/bin/bash
#FLUX: --job-name=anxious-leader-4259
#FLUX: -N=32
#FLUX: --queue=premium
#FLUX: -t=3600
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export CRAY_ACCEL_TARGET='nvidia80'
export LD_LIBRARY_PATH='$NVSHMEM_HOME/lib:$LD_LIBRARY_PATH'
export SUPERLU_LBS='GD  '
export SUPERLU_ACC_OFFLOAD='1 # this can be 0 to do CPU tests on GPU nodes'
export GPU3DVERSION='1'
export ANC25D='0'
export NEW3DSOLVE='1    '
export NEW3DSOLVETREECOMM='1'
export SUPERLU_BIND_MPI_GPU='1 # assign GPU based on the MPI rank, assuming one MPI per GPU'
export SUPERLU_MAXSUP='256 # max supernode size'
export SUPERLU_RELAX='64  # upper bound for relaxed supernode size'
export SUPERLU_MAX_BUFFER_SIZE='10000000 ## 500000000 # buffer size in words on GPU'
export SUPERLU_NUM_LOOKAHEADS='2   ##4, must be at least 2, see 'lookahead winSize'
export SUPERLU_NUM_GPU_STREAMS='1'
export SUPERLU_MPI_PROCESS_PER_GPU='1 # 2: this can better saturate GPU'
export SUPERLU_N_GEMM='6000 # FLOPS threshold divide workload between CPU and GPU'
export NVSHMEM_USE_GDRCOPY='1'
export NVSHMEM_MPI_SUPPORT='1'
export MPI_HOME='${MPICH_DIR}'
export NVSHMEM_LIBFABRIC_SUPPORT='1'
export LIBFABRIC_HOME='/opt/cray/libfabric/1.15.2.0'
export NVSHMEM_DISABLE_CUDA_VMM='1'
export FI_CXI_OPTIMIZED_MRS='false'
export NVSHMEM_BOOTSTRAP_TWO_STAGE='1'
export NVSHMEM_BOOTSTRAP='MPI'
export NVSHMEM_REMOTE_TRANSPORT='libfabric'
export OMP_NUM_THREADS='$NTH'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export SLURM_CPU_BIND='cores'
export MPICH_MAX_THREAD_SAFETY='multiple'
export SUPERLU_ACC_SOLVE='0'

module load PrgEnv-nvidia 
module load cudatoolkit
module load cray-libsci
module load cmake
out=out_slu
mkdir $out
export MPICH_GPU_SUPPORT_ENABLED=1
export CRAY_ACCEL_TARGET=nvidia80
echo MPICH_GPU_SUPPORT_ENABLED=$MPICH_GPU_SUPPORT_ENABLED
export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:$LD_LIBRARY_PATH
export SUPERLU_LBS=GD  
export SUPERLU_ACC_OFFLOAD=1 # this can be 0 to do CPU tests on GPU nodes
export GPU3DVERSION=1
export ANC25D=0
export NEW3DSOLVE=1    
export NEW3DSOLVETREECOMM=1
export SUPERLU_BIND_MPI_GPU=1 # assign GPU based on the MPI rank, assuming one MPI per GPU
export SUPERLU_MAXSUP=256 # max supernode size
export SUPERLU_RELAX=64  # upper bound for relaxed supernode size
export SUPERLU_MAX_BUFFER_SIZE=10000000 ## 500000000 # buffer size in words on GPU
export SUPERLU_NUM_LOOKAHEADS=2   ##4, must be at least 2, see 'lookahead winSize'
export SUPERLU_NUM_GPU_STREAMS=1
export SUPERLU_MPI_PROCESS_PER_GPU=1 # 2: this can better saturate GPU
export SUPERLU_N_GEMM=6000 # FLOPS threshold divide workload between CPU and GPU
NVSHMEM_HOME=/global/cfs/cdirs/m3894/lib/PrgEnv-gnu/nvshmem_src_2.8.0-3/build/
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
export NVSHMEM_REMOTE_TRANSPORT=libfabric
if [[ $NERSC_HOST == edison ]]; then
  CORES_PER_NODE=24
  THREADS_PER_NODE=48
elif [[ $NERSC_HOST == cori ]]; then
  CORES_PER_NODE=32
  THREADS_PER_NODE=64
  # This does not take hyperthreading into account
elif [[ $NERSC_HOST == perlmutter ]]; then
  CORES_PER_NODE=64
  THREADS_PER_NODE=128
  GPUS_PER_NODE=4
else
  # Host unknown; exiting
  exit $EXIT_HOST
fi
nprows=(2)
npcols=(4)
npz=(16)
nrhs=(1)
NTH=1
NREP=1
for ((i = 0; i < ${#npcols[@]}; i++)); do
NROW=${nprows[i]}
NCOL=${npcols[i]}
NPZ=${npz[i]}
for ((s = 0; s < ${#nrhs[@]}; s++)); do
NRHS=${nrhs[s]}
CORE_VAL2D=`expr $NCOL \* $NROW`
NODE_VAL2D=`expr $CORE_VAL2D / $GPUS_PER_NODE`
MOD_VAL=`expr $CORE_VAL2D % $GPUS_PER_NODE`
if [[ $MOD_VAL -ne 0 ]]
then
  NODE_VAL2D=`expr $NODE_VAL2D + 1`
fi
CORE_VAL=`expr $NCOL \* $NROW \* $NPZ`
NODE_VAL=`expr $CORE_VAL / $GPUS_PER_NODE`
MOD_VAL=`expr $CORE_VAL % $GPUS_PER_NODE`
if [[ $MOD_VAL -ne 0 ]]
then
  NODE_VAL=`expr $NODE_VAL + 1`
fi
batch=0 # whether to do batched test
NCORE_VAL_TOT=`expr $NROW \* $NCOL \* $NPZ `
NCORE_VAL_TOT2D=`expr $NROW \* $NCOL `
OMP_NUM_THREADS=$NTH
TH_PER_RANK=`expr $NTH \* 2`
export OMP_NUM_THREADS=$NTH
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export SLURM_CPU_BIND="cores"
export MPICH_MAX_THREAD_SAFETY=multiple
for MAT in cg20.cua
do
mkdir -p $MAT
for ii in `seq 1 $NREP`
do	
export SUPERLU_ACC_SOLVE=0
for f in Hmat_100 Hmat_150 Hmat_200; do
    echo "srun -n $NCORE_VAL_TOT  -c $TH_PER_RANK --cpu_bind=cores /pscratch/sd/p/pghysels/BLR_GPU_experiments/perlmutter/code/superlu_dist_Yang/build/EXAMPLE/pzdrive3d -c $NCOL -r $NROW -d $NPZ -b $batch -i 0 -s $NRHS /pscratch/sd/p/pghysels/${f}.mtx | tee ./${out}/SLU_${f}.o_mpi_${NROW}x${NCOL}x${NPZ}_${OMP_NUM_THREADS}_3d_newest_gpusolve_${SUPERLU_ACC_SOLVE}_nrhs_${NRHS}"
    srun -n $NCORE_VAL_TOT  -c $TH_PER_RANK --cpu_bind=cores /pscratch/sd/p/pghysels/BLR_GPU_experiments/perlmutter/code/superlu_dist_Yang/build/EXAMPLE/pzdrive3d -c $NCOL -r $NROW -d $NPZ -b $batch -i 0 -s $NRHS /pscratch/sd/p/pghysels/${f}.mtx | tee ./${out}/SLU_${f}.o_mpi_${NROW}x${NCOL}x${NPZ}_${OMP_NUM_THREADS}_3d_newest_gpusolve_${SUPERLU_ACC_SOLVE}_nrhs_${NRHS}
done
done
done
done
done
