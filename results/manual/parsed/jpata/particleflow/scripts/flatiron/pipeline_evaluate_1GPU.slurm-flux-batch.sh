#!/bin/bash
#FLUX: --job-name=chocolate-house-8052
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/'

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
train_dir="experiments/hits_bs16_clic-hits_20230508_064411_129925_RESUMED2_clic-hits_20230522_170633_350485.workergpu064"
echo 'Starting evaluation.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py evaluate \
    --train-dir $train_dir
echo 'Evaluation done.'
echo 'Starting plotting.'
CUDA_VISIBLE_DEVICES=0 python3 mlpf/pipeline.py plots \
    --train-dir $train_dir
echo 'Plotting done.'
