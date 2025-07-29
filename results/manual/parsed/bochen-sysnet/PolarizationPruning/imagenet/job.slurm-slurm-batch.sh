#!/bin/bash
#SBATCH --job-name=m2ofa
#SBATCH --account=bbod-delta-gpu
#SBATCH --output=m2ofa.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=220G
#SBATCH --time=20:00:00
#SBATCH --partition=gpuA40x4
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1,scratch
#SBATCH: --no-requeue

export OMP_NUM_THREADS='16  # if code is not multithreaded, otherwise set to 16 or 16'

cd /scratch/bbng/boc2/PolarizationPruning/imagenet/
source /sw/external/python/anaconda3/etc/profile.d/conda.sh
conda activate boenv
export OMP_NUM_THREADS=16  # if code is not multithreaded, otherwise set to 16 or 16
srun python3 -W ignore -u main_oneshot.py /scratch/bbng/boc2/datasets/imagenet -loss ps --warmup -b 1024 --lbd 2.5e-5 --t 1 --lr-strategy cos --lr 0.4 --epochs 256 --wd 0.00004 --no-bn-wd --arch mobilenetv2 --workers 16 --world-size 1 --dist-url tcp://localhost:23456 --dist-backend gloo --rank 0 --save ./ofa/mobilenetv2/ --resume ../../BackupPolarizationPruning/imagenet/ofa/mobilenetv2/checkpoint.pth.tar --OFA
