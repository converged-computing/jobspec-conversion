#!/bin/bash
#SBATCH --output=/network/scratch/k/karam.ghanem/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=48G

module load miniconda/3 cuda/11.7
conda activate edm
python fid.py ref --data=/home/mila/k/karam.ghanem/scratch/datasets/imagenet-64x64.zip --dest=/home/mila/k/karam.ghanem/scratch/datasets/imagenet-64x64.npz
cp $SLURM_TMPDIR  /network/scratch/k/karam.ghanem
