#!/bin/bash
#FLUX: --job-name=sensitive_ana1
#FLUX: --queue=gpu-cascade
#FLUX: -t=172800
#FLUX: --urgency=16

module load gcc/8.2.0
module load nvidia/nvhpc
module load nvidia/nvhpc-nompi/22.2
module load nvidia/cudnn/8.2.1-cuda-11.6
module load openmpi/4.1.2-cuda-11.6
module load mpi4py/3.1.3-ompi-gpu
module load horovod/0.24.2-gpu
python main.py --lr 0.5 --eps 0.1 --model vgg_bn --optim theopoula --seed 222 --dataset cifar10
python main.py --lr 0.5 --eps 0.1 --model resnet --optim theopoula --seed 222 --dataset cifar10
python main.py --lr 0.5 --eps 0.1 --model vgg_bn --optim theopoula --seed 222 --dataset cifar100
python main.py --lr 0.5 --eps 0.01 --model resnet --optim theopoula --seed 222 --dataset cifar100
python main.py --lr 0.1 --eps 1 --model vgg_bn --optim theopoula --seed 222 --dataset cifar10
python main.py --lr 0.1 --eps 1 --model resnet --optim theopoula --seed 222 --dataset cifar10
python main.py --lr 0.1 --eps 1 --model vgg_bn --optim theopoula --seed 222 --dataset cifar100
python main.py --lr 0.05 --eps 1 --model resnet --optim theopoula --seed 222 --dataset cifar100
python main.py --lr 0.5 --eps 0.1 --model vgg_bn --optim theopoula --seed 333 --dataset cifar10
python main.py --lr 0.5 --eps 0.1 --model resnet --optim theopoula --seed 333 --dataset cifar10
python main.py --lr 0.5 --eps 0.1 --model vgg_bn --optim theopoula --seed 333 --dataset cifar100
python main.py --lr 0.5 --eps 0.01 --model resnet --optim theopoula --seed 333 --dataset cifar100
python main.py --lr 0.1 --eps 1 --model vgg_bn --optim theopoula --seed 333 --dataset cifar10
python main.py --lr 0.1 --eps 1 --model resnet --optim theopoula --seed 333 --dataset cifar10
python main.py --lr 0.1 --eps 1 --model vgg_bn --optim theopoula --seed 333 --dataset cifar100
python main.py --lr 0.05 --eps 1 --model resnet --optim theopoula --seed 333 --dataset cifar100
