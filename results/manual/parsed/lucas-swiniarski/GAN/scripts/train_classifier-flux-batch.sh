#!/bin/bash
#FLUX: --job-name=generator-classifiers
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load pytorch/intel/20170226
module load torchvision/0.1.7
cd /scratch/ls4411/Research/GAN/QualityAssessor
DIR_NAME="cifar10"
FILE_NAME="all-dataset"
python classify.py --epochs=200 --train-real=True --dataset=cifar10 --imageSize=32 --cuda --netG=../TrainedNetworks/$DIR_NAME/$FILE_NAME &> /scratch/ls4411/Research/GAN/TrainedNetworks/$DIR_NAME/$FILE_NAME-classify-output.txt
exit 0
