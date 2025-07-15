#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=86400
#FLUX: --priority=16

source scripts/startup.sh
cd third_party/imagenet-autoencoder
python visualize_clustering.py --arch "vgg16" \
 --val_list "perseverance_navcam_color" \
 --resume "/cluster/scratch/horatan/mars/results_vgg16/051.pth"
