#!/bin/bash
#FLUX: --job-name=PatchExtractor
#FLUX: -c=12
#FLUX: --queue=gpuhm
#FLUX: -t=273600
#FLUX: --priority=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
mamba activate  dl_torch
cd /home/ofourkioti/Projects/GT-2022-histo/feature_extractor/
python compute_feats_res.py --weights "runs/tcga_rcc/checkpoints/rcc_model.pth"  --dataset "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/patches/*" --output "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/feats/" --slide_dir /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/slides/TCGA_RCC/
