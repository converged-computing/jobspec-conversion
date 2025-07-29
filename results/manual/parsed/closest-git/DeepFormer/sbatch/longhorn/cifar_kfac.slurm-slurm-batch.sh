#!/bin/bash
#SBATCH --job-name=cifkfc4
#SBATCH --account=XXX
#SBATCH --output=sbatch_logs/cif_kfc4.o%j
#SBATCH --mail-user=XXX
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

mkdir -p sbatch_logs
source $SCRATCH/anaconda3/bin/activate pytorch
scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 4 \
   python examples/pytorch_cifar10_resnet.py \
     --base-lr 0.1 \
     --epochs 100 \
     --kfac-update-freq 10 \
     --model resnet32 \
     --lr-decay 35 75 90
