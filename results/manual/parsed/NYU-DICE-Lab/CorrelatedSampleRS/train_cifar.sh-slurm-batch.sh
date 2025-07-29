#!/bin/bash
#SBATCH --job-name=sd
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=22GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python/intel/3.8.6
source ../../env/bin/activate
python3 train_smooth.py cifar10 -mt resnet110 -dpath "/scratch/mp5847/dataset/" --noise_sd 0.25 --outdir "/scratch/mp5847/checkpoints" --workers 6
