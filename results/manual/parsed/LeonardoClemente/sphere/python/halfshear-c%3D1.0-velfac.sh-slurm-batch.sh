#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LeonardoClemente/sphere/python/halfshear-c%3D1.0-velfac.sh
