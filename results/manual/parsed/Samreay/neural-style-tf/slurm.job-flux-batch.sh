#!/bin/bash
#FLUX: --job-name=angry-citrus-3605
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load compilers/cuda/9.2
. ~/miniconda/etc/profile.d/conda.sh
conda activate style
startt=$(date +"%T")
python neural_style.py --content_img ducky_profile.jpg --style_imgs galaxy.jpg --max_size 1500 --max_iterations 1000 --device /gpu:0 --verbose
endt=$(date +"%T")
echo "Start to finish time: $startt -> $endt"
