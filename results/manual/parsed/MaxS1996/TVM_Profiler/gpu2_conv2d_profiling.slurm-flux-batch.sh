#!/bin/bash
#FLUX: --job-name=conv2d_TVMquick
#FLUX: -c=8
#FLUX: --queue=gpu2
#FLUX: -t=86400
#FLUX: --priority=16

export TVM_HOME='/home/s0144002/tvm_gpu2_power'
export PYTHONPATH='$TVM_HOME/python:${PYTHONPATH}'
export PAPI_CUDA_ROOT='$CUDA_ROOT'

pwd; hostname; date
echo "Running TVM conv2d grid search profiler on $SLURM_CPUS_ON_NODE CPU cores"
echo ""
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
module load CUDA/11.1.1 LLVM/11.0.0 CMake/3.18.4-GCCcore-10.2.0 Python/3.8.6
source ~/DIR/ssd/s0144002-TVMMapper/python_envs/gpu2/bin/activate
export TVM_HOME=/home/s0144002/tvm_gpu2_power
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
export PAPI_CUDA_ROOT=$CUDA_ROOT
cd ~/DIR/ssd/s0144002-TVMMapper/TVM_Profiler
python3 template_profiling.py -t gpu2 -w conv2d
