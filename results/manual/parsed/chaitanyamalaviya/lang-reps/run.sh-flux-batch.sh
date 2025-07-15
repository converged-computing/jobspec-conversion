#!/bin/bash
#FLUX: --job-name=psycho-fudge-0430
#FLUX: --priority=16

export DYLD_LIBRARY_PATH='/home/cmalaviy/dynet/build/dynet/:$DYLD_LIBRARY_PATH'
export LD_LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'
export CPATH='/opt/cudnn-8.0/include:$CPATH'
export LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'

module load cuda-8.0 cudnn-8.0-5.1
source activate dynet
export DYLD_LIBRARY_PATH=/home/cmalaviy/dynet/build/dynet/:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cuda-8.0/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
export CPATH=/opt/cudnn-8.0/include:$CPATH
export LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
