#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=your
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

pwd
date
source ~/python-env/cuda10-home/bin/activate
cd /scratch1/07801/nusbin20/tacc-our
module load intel/18.0.5 impi/18.0.5
module load cuda/10.1 cudnn nccl
ibrun -np 8 \
	python pytorch_imagenet_resnet.py  \
	--epochs 90 \
	--model resnet50
