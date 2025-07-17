#!/bin/bash
#FLUX: --job-name=pipeeval
#FLUX: --queue=dc-gpu
#FLUX: -t=7199
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC GCCcore/.11.2.0 CMake NCCL CUDA cuDNN OpenMPI
export CUDA_VISIBLE_DEVICES=0
jutil env activate -p raise-ctp2
nvidia-smi
source /p/project/raise-ctp2/cern/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
echo 'Starting evaluation.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py compute_validation_loss -t $1
echo 'Evaluation done.'
