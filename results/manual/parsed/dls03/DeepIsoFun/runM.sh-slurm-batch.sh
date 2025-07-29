#!/bin/bash
#SBATCH --job-name=rM
#SBATCH --output=mytesty.stdout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=3-00:15:00

date
module load caffe
module load cuda/8.0
module load cuDNN/6.0
module load opencv
module load glog
python DeepIsoFun/deepisofun3.py
