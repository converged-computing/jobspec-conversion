#!/bin/bash
#FLUX: --job-name=gin
#FLUX: --gpus-per-task=1
#FLUX: -t=43200
#FLUX: --urgency=16

echo $CUDA_VISIBLE_DEVICES 
source /vols/opig/users/raja/miniconda3/etc/profile.d/conda.sh
conda activate gin_conda
python GDL-ActivityCliff-3D/gin_exp.py --dataset postera_sars_cov_2_mpro --model knn >> GDL-ActivityCliff-3D/terminal_output/gin_knn2.txt
