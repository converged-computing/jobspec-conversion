#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LeonardoClemente/sphere/python/diffusivity-c_grad_p%3D0.01.sh
