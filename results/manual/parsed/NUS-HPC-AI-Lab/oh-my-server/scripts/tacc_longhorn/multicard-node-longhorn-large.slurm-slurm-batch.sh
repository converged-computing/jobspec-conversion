#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --mail-user=your
#SBATCH --mail-type=all
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=v100

pwd
date
cd /scratch/07801/nusbin20/tacc-our
module load conda
conda activate py36pt
scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 1 ./cp_imagenet_to_temp_bin.sh
ibrun -np 8 \
python examples/pytorch_imagenet_resnet.py \
--epochs 90 \
--model resnet50
