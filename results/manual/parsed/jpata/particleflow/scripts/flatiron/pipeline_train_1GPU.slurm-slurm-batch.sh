#!/bin/bash
#SBATCH --job-name=pipetrain
#SBATCH --output=logs_slurm/log_%x_%j.out
#SBATCH --error=logs_slurm/log_%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=200G
#SBATCH --time=7-00:00:00
#SBATCH --constraint=a100-80gb,ib

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/'
export TF_GPU_THREAD_MODE='gpu_private'
export TF_GPU_THREAD_COUNT='2'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.1.1-20230405
module load slurm gcc cmake nccl cuda/11.8.0 cudnn/8.4.0.27-11.6 openmpi/4.0.7
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/
export TF_GPU_THREAD_MODE=gpu_private
export TF_GPU_THREAD_COUNT=2
nvidia-smi
echo 'Starting training.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py train -c $1 -p $2 \
    --seeds --comet-exp-name particleflow-tf-clic
echo 'Training done.'
