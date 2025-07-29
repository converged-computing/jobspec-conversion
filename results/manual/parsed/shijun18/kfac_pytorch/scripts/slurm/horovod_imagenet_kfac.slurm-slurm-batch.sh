#!/bin/bash
#SBATCH --job-name=imgkfc16
#SBATCH --account=XXX
#SBATCH --output=imgnet_kfc16.o%j
#SBATCH --mail-user=XXX
#SBATCH --mail-type=end
#SBATCH --nodes=16
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 1 ./scripts/cp_imagenet_to_temp.sh
mpiexec -hostfile /tmp/hostfile -N 4 \
   python examples/horovod_imagenet_resnet.py \
     --kfac-update-freq 100 \
     --kfac-cov-update-freq 10 \
     --damping 0.001 \
     --epochs 55 \
     --lr-decay 25 35 40 45 50 \
     --model resnet50
