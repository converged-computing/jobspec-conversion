#!/bin/bash
#SBATCH --job-name=SCELoss
#SBATCH --account=punim0784
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=64G
#SBATCH --time=04:00:00

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/SCELoss
module load Python/3.6.4-intel-2017.u2-GCC-6.2.0-CUDA10
nvidia-smi
python3 -u train.py  --loss         CE                \
                     --dataset_type cifar10           \
                     --l2_reg       1e-2              \
                     --seed         123               \
                     --version      CE0.8_CIFAR10     \
                     --nr           0.8
python3 -u train.py  --lr           0.01              \
                     --loss         CE                \
                     --dataset_type cifar100          \
                     --l2_reg       1e-2              \
                     --seed         123               \
                     --version      CE0.8_CIFAR100    \
                     --nr           0.8
