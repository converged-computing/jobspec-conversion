#!/bin/bash
#FLUX: --job-name=fuzzy-milkshake-6993
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python main.py \
--inference_dir demo/kitti \
--output_path output/gmflow-norefine-sintel_market_1 \
--resume pretrained/gmflow_kitti-285701a8.pth \
python main.py \
--inference_dir demo/kitti \
--output_path output/ \
--resume pretrained/gmflow_with_refine_kitti-8d3b9786.pth \
--padding_factor 32 \
--upsample_factor 4 \
--num_scales 2 \
--attn_splits_list 2 8 \
--corr_radius_list -1 4 \
--prop_radius_list -1 1 \
