#!/bin/bash
#FLUX: --job-name="SCELoss"
#FLUX: -c=4
#FLUX: --queue=gpgpu
#FLUX: -t=14400
#FLUX: --priority=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/SCELoss
module load Python/3.6.4-intel-2017.u2-GCC-6.2.0-CUDA10
nvidia-smi
python3 -u train.py  --loss         SCE               \
                     --dataset_type cifar10           \
                     --l2_reg       1e-2              \
                     --seed         123               \
                     --alpha        0.1               \
                     --beta         1.0               \
                     --version      SCE0.0_CIFAR10    \
                     --nr           0.0
python3 -u train.py  --lr           0.01              \
                     --loss         SCE               \
                     --dataset_type cifar100          \
                     --l2_reg       1e-2              \
                     --seed         123               \
                     --alpha        6.0               \
                     --beta         1.0               \
                     --version      SCE0.0_CIFAR100   \
                     --nr           0.0
