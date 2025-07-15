#!/bin/bash
#FLUX: --job-name=moolicious-plant-1933
#FLUX: --queue=small
#FLUX: -t=43200
#FLUX: --urgency=16

module load cuda/10.2
module load python/anaconda3
conda activate superpixels
SIZE=$(echo "$SIZE" | bc)
model_id="ResNet"
python3 main.py --image_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/coco/${SET}2014/ \
		--save_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/${model_id}/whole_img \
		--model_id ${model_id} \
		--whole_img
python3 merge_and_clean.py --input_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/${model_id}/whole_img \
							--output_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/${model_id}/whole_img
