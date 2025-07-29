#!/bin/bash
#SBATCH --job-name=inference
#SBATCH --output=%x_slurm_%j.out
#SBATCH --error=%xslurm_%j.err
#SBATCH --mail-user=zzhou82@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=80G
#SBATCH --time=03:00:00

module load mamba/latest # only for Sol
source activate suprem
pretrainpath=./pretrained_checkpoints/swin_unetr_totalsegmentator_vertebrae.pth
savepath=./AbdomenAtlasDemoPredict
datarootpath=/scratch/zzhou82/2024_0322/AbdomenAtlasDemo
python -W ignore inference.py --save_dir $savepath --checkpoint $pretrainpath --data_root_path $datarootpath --customize
