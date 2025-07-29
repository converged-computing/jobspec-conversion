#!/bin/bash
#SBATCH --job-name=PatchExtractor
#SBATCH --output=/home/ofourkioti/Projects/GT-2022-histo/results/rcc_feats.out
#SBATCH --error=/home/ofourkioti/Projects/GT-2022-histo/alma_run_files/error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --time=3-04:00:00
#SBATCH --partition=gpuhm

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
mamba activate  dl_torch
cd /home/ofourkioti/Projects/GT-2022-histo/feature_extractor/
python compute_feats_res.py --weights "runs/tcga_rcc/checkpoints/rcc_model.pth"  --dataset "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/patches/*" --output "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/feats/" --slide_dir /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/slides/TCGA_RCC/
