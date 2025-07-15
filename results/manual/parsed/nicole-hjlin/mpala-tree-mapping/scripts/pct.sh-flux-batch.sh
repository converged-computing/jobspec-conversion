#!/bin/bash
#FLUX: --job-name=nerdy-gato-6975
#FLUX: --urgency=16

set -x
module load Anaconda3/2020.11
module load cuda/11.7.1-fasrc01
module load gcc/10.2.0-fasrc01
pip install ./PCT_Pytorch/pointnet2_ops_lib
python3 -m pct_main --exp_name pct --batch_size 32 --test_batch_size 32 --epochs 100 --num_points 1000 --min_points 1000 --dropout 0.5 --data_dir ../data/MpalaForestGEO_LasClippedtoTreePolygons --label_path labels.csv --output_channels 6 --top_species 5 --lr 1e-5
