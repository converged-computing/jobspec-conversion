#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10g

export LD_LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'
export CPATH='/opt/cudnn-8.0/include:$CPATH'
export LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'

set -x  # echo commands to stdout
set -e  # exit on error
module load cuda-8.0
module load cudnn-8.0-5.1
source activate dynet
export LD_LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
export CPATH=/opt/cudnn-8.0/include:$CPATH
export LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
