#!/bin/bash
#FLUX: --job-name=bloated-spoon-5154
#FLUX: -t=82800
#FLUX: --priority=16

module load python/gpu
pip install visdom
pip install dominate
python train.py --dataroot /N/project/polycrystalGAN/polycrystal/pytorch-CycleGAN-and-pix2pix/datasets/1000 --name 001 --model pix2pix --direction AtoB
python test_loop.py --dataroot /N/project/polycrystalGAN/polycrystal/pytorch-CycleGAN-and-pix2pix/datasets/1000 --direction AtoB --model pix2pix --name 001
