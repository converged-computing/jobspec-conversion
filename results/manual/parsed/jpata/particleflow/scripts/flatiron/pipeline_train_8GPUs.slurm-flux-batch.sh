#!/bin/bash
#FLUX: --job-name=pipetrain
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.1.1-20230405
module load slurm gcc cmake nccl cuda/12.0.0 cudnn/8.4.0.27-11.6 openmpi/4.0.7
nvidia-smi
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 python3 mlpf/pipeline.py train -c $1 -p $2 \
    --seeds --comet-exp-name particleflow-tf-clic
echo 'Training done.'
