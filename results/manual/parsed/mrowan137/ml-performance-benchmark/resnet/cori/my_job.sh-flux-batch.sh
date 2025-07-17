#!/bin/bash
#FLUX: --job-name=resnet50-cgpu
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export BATCHSIZE='64'
export DO_PROFILING='false'  # true or false'
export DO_NCCL_DEBUG='false' # true or false'
export PYTHONPATH='$(pwd):/usr/common/software/tensorflow/gpu-tensorflow/1.15.0-py37/bin/python'
export MODELDIR='results/${SLURM_NNODES}_nodes_batchsize_${BATCHSIZE}_j${SLURM_JOB_ID}/model_dir'
export NODES='$SLURM_NNODES'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=$CUDA_PATH'
export TF_XLA_FLAGS='tf_xla_cpu_global_jit'
export DATADIR='/global/cfs/cdirs/nstaff/ai_benchmark/michael/data/imagenet/all_data'

export BATCHSIZE=64
export DO_PROFILING='false'  # true or false
export DO_NCCL_DEBUG='false' # true or false
                             # only set at most one of DO_PROFILING,
                             # DO_NCCL_DEBUG to True
module purge
module load cgpu
module load tensorflow/gpu-1.15.0-py37
export PYTHONPATH=$(pwd):/usr/common/software/tensorflow/gpu-tensorflow/1.15.0-py37/bin/python
export MODELDIR=results/${SLURM_NNODES}_nodes_batchsize_${BATCHSIZE}_j${SLURM_JOB_ID}/model_dir
export NODES=$SLURM_NNODES
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_PATH
export TF_XLA_FLAGS=tf_xla_cpu_global_jit
if [ "$DO_PROFILING" == "true" ]
then
    module load nsight-systems
fi
export DATADIR=/global/cfs/cdirs/nstaff/ai_benchmark/michael/data/imagenet/all_data
if [ "$DO_PROFILING" == "true" ]
then
    srun -N $SLURM_NNODES -n $SLURM_NTASKS -c 10 \
         --cpu-bind=cores \
         ./utils/run_with_profiling.sh
else
    srun -N $SLURM_NNODES -n $((SLURM_NNODES*8)) -c 10 \
         --cpu-bind=cores \
         ./utils/run.sh
fi
