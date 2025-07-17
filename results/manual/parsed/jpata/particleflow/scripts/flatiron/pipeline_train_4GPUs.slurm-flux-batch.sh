#!/bin/bash
#FLUX: --job-name=pipetrain
#FLUX: --gpus-per-task=4
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/'
export TF_GPU_THREAD_MODE='gpu_private'
export TF_GPU_THREAD_COUNT='2'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.1.1-20230405
module load slurm gcc cmake nccl cuda/11.8.0 cudnn/8.4.0.27-11.6 openmpi/4.0.7
nvidia-smi
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/
export TF_GPU_THREAD_MODE=gpu_private
export TF_GPU_THREAD_COUNT=2
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 mlpf/pipeline.py train -c $1 -p $2 \
    --seeds --comet-exp-name particleflow-tf-clic
echo 'Training done.'
