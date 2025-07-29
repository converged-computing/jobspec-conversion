#!/bin/bash
#SBATCH --job-name=GAN_test
#SBATCH --output=filename_%j.txt
#SBATCH --error=filename_%j.err
#SBATCH --mail-user=yw132@iu.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

module load python/gpu
pip install visdom
pip install dominate
python train.py --dataroot /N/project/polycrystalGAN/polycrystal/pytorch-CycleGAN-and-pix2pix/datasets/1000 --name 001 --model pix2pix --direction AtoB
python test_loop.py --dataroot /N/project/polycrystalGAN/polycrystal/pytorch-CycleGAN-and-pix2pix/datasets/1000 --direction AtoB --model pix2pix --name 001
