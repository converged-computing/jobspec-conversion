#!/bin/bash
#FLUX: --job-name=pipetrain
#FLUX: --queue=dc-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module purge
module load GCC GCCcore/.11.2.0 CMake NCCL CUDA cuDNN OpenMPI
export CUDA_VISIBLE_DEVICES=0,1,2,3
jutil env activate -p raise-ctp2
nvidia-smi
source /p/project/raise-ctp2/cern/miniconda3/bin/activate tf2
echo "Python used:"
which python3
python3 --version
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 mlpf/pipeline.py train -c $1 -p $2 --comet-offline -j $SLURM_JOBID
echo 'Training done.'
