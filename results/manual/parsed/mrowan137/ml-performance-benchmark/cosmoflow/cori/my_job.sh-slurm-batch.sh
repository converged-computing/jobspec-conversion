#!/bin/bash
#SBATCH --job-name=cosmoflow-cgpu
#SBATCH --account=nstaff
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH: --exclusive
#SBATCH --constraint=gpu,ntasks-per-node=8

export BATCHSIZE='8'
export DO_PROFILING='false'  # true or false'
export DO_NCCL_DEBUG='false' # true or false'
export PYTHONPATH='/usr/common/software/tensorflow/2.4.1-gpu/bin/python'
export NODES='${SLURM_NNODES}'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=$CUDA_DIR'

export BATCHSIZE=8
export DO_PROFILING='false'  # true or false
export DO_NCCL_DEBUG='false' # true or false
                             # only set at most one of DO_PROFILING,
                             # DO_NCCL_DEBUG to True
module purge
module load cgpu
module load tensorflow/2.4.1-gpu
export PYTHONPATH=/usr/common/software/tensorflow/2.4.1-gpu/bin/python
export NODES=${SLURM_NNODES}
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_DIR
if [ "$DO_PROFILING" == "true" ]
then
    module load nsight-systems
    srun -N $SLURM_NNODES -n $((SLURM_NNODES*8)) -c 10 \
         --cpu-bind=cores \
         ./utils/run_with_profiling.sh
else
    srun -N $SLURM_NNODES -n $((SLURM_NNODES*8)) -c 10 \
         --cpu-bind=cores \
         ./utils/run.sh
fi
