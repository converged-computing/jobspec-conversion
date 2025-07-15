#!/bin/bash
#FLUX: --job-name=dirty-itch-8852
#FLUX: --queue=small
#FLUX: -t=43200
#FLUX: --urgency=16

module load cuda/10.2
module load python/anaconda3
conda activate superpixels
SIZE=$(echo "$SIZE" | bc)
model_id="ResNet"
python3 main.py --image_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/coco/${SET}2014/ \
		--save_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/ResNet/${SET}_patches \
		--model_id ${model_id} \
		--patches
python3 merge_and_clean.py --input_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/ResNet/${SET}_patches \
							--output_dir /jmain02/home/J2AD007/txk47/hxs67-txk47/superpixel_features/ResNet/patches
