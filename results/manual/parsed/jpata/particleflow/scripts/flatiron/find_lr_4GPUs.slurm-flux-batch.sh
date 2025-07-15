#!/bin/bash
#FLUX: --job-name=persnickety-buttface-6721
#FLUX: --priority=16

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.0-20220630
module load slurm gcc cmake/3.22.3 nccl cuda/11.4.4 cudnn/8.2.4.15-11.4 openmpi/4.0.7
nvidia-smi
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 mlpf/pipeline.py find-lr -c $1
