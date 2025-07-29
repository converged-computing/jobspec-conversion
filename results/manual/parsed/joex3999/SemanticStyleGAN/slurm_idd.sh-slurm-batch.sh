#!/bin/bash
#SBATCH --job-name=SemanticStyleGan_IDD
#SBATCH --output=./log_files/IDD_rectangle/SSG%j.%N_output.out
#SBATCH --error=./log_files/IDD_rectangle/SSG%j.%N_error.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=4-23:00:00
#SBATCH --qos=batch

module load cuda/11.3
python3.9 prepare_image_data.py  /data/public/idd-segmentation/IDD_Segmentation/leftImg8bit  --out /no_backups/g013/data/IDD/lmdb_datasets/lmdb_v1_images_only --size 256
