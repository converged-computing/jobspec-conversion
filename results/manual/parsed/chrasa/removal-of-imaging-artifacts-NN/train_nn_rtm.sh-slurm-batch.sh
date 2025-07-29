#!/bin/bash
#SBATCH --job-name=train_nn_rtm
#SBATCH --account=snic2022-22-1060
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --partition=core
#SBATCH --chdir=./

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib'

conda activate tf
nvidia-smi
CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib
echo "Train networks..."
python3 train_nn.py rtm ConvNNshallow sobel -stride 5 -nimages 4080
python3 train_nn.py rtm ConvNNshallow ssim -stride 5 -nimages 4080
python3 train_nn.py rtm ConvNNdeep sobel -stride 5 -nimages 4080
python3 train_nn.py rtm ConvNNdeep ssim -stride 5 -nimages 4080
echo " "
echo "Finished calculations"
