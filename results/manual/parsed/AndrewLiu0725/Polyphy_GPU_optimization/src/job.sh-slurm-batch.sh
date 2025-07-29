#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=ACD109080
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=1

module load intel/2018
module load nvidia/cuda/10.0
/home/ajl870725/cudaDPLB_v0.1_wip/src/dplbe
