#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CasperAntonPoulsen/Thesis-Synthex/pytorch-CycleGAN-and-pix2pix/synthex_training.job
