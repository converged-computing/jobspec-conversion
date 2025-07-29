#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=./logs/cluster_imagenet-autoencoder.out
#SBATCH --error=./logs/cluster_imagenet-autoencoder.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=1-00:00:00

source scripts/startup.sh
cd third_party/imagenet-autoencoder
python visualize_clustering.py --arch "vgg16" \
 --val_list "perseverance_navcam_color" \
 --resume "/cluster/scratch/horatan/mars/results_vgg16/051.pth"
