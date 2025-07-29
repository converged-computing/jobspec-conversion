#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=d2021-135-users
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module add Anaconda3/2020.11
conda activate /ceph/hpc/home/euqiamgl/.conda/envs/pyhpda
python $1 > $1.out
exit 0
