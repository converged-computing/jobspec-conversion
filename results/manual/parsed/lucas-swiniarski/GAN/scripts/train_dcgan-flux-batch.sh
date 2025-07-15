#!/bin/bash
#FLUX: --job-name=acwg-clamp-b
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --priority=16

module purge
module load python/intel/2.7.12
module load cuda/8.0.44
module load cudnn/8.0v5.1
cd /scratch/ls4411/Research/GAN/CycleGAN
DIR_NAME="cifar10-cycle"
FILE_NAME="cycle"
mkdir ../TrainedNetworks/$DIR_NAME
pip install http://download.pytorch.org/whl/cu80/torch-0.1.11.post5-cp27-none-linux_x86_64.whl --user
pip install torchvision --user
python main.py --bias --nz=1000 --noise=.1 --n-critic=5 --clamp --wasserstein --model-g=upsampling --dataset=cifar10 --cuda--name=/$DIR_NAME/$FILE_NAME &> /scratch/ls4411/Research/GAN/TrainedNetworks/$DIR_NAME/$FILE_NAME-output.txt
exit 0
