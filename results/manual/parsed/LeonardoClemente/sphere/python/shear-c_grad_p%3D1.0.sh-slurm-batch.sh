#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LeonardoClemente/sphere/python/shear-c_grad_p%3D1.0.sh
