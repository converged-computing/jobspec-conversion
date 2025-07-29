#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LeonardoClemente/sphere/python/halfshear-c_v%3D1.0-c_a%3D0.0-velfac.sh
