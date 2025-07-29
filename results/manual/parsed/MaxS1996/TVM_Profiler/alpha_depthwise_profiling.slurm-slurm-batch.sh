#!/bin/bash
#SBATCH --job-name=TVMquick
#SBATCH --output=depthwise_template_runner.log
#SBATCH --mail-user=s0144002@msx.tu-dresden.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=11000
#SBATCH --time=1-00:00:00
#SBATCH --partition=alpha

export TVM_HOME='/home/s0144002/tvm_alpha_power'
export PYTHONPATH='$TVM_HOME/python:${PYTHONPATH}'
export PAPI_CUDA_ROOT='$CUDA_ROOT'

pwd; hostname; date
echo "Running TVM dense grid search profiler on $SLURM_CPUS_ON_NODE CPU cores"
echo ""
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
module load CUDA/11.1.1 LLVM/11.0.0 CMake/3.18.4-GCCcore-10.2.0 Python/3.8.6
source ~/DIR/ssd/s0144002-TVMMapper/python_envs/alpha_tvm09/bin/activate
export TVM_HOME=/home/s0144002/tvm_alpha_power
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
export PAPI_CUDA_ROOT=$CUDA_ROOT
cd ~/DIR/ssd/s0144002-TVMMapper/TVM_Profiler
python3 template_profiling.py -w depthwise_conv2d
