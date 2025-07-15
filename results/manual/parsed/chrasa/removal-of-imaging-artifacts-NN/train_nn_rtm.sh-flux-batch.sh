#!/bin/bash
#FLUX: --job-name=scruptious-punk-8754
#FLUX: --priority=16

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
