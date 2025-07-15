#!/bin/bash
#FLUX: --job-name=PatchExtractor
#FLUX: -c=10
#FLUX: --queue=gpuhm
#FLUX: -t=360000
#FLUX: --priority=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
mamba activate  dl_torch
cd /home/ofourkioti/Projects/tmi2022/
python src/vis_graphcam.py --path_file "cam_16_splits/test_0.txt"  --path_patches "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/cam-16/tiles/" --path_WSI "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/slides/camelyon16/" --path_graph "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/cam-16/graphs/simclr_files/"
