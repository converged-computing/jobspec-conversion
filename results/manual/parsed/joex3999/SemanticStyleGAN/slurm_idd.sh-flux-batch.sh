#!/bin/bash
#FLUX: --job-name="SemanticStyleGan_IDD"
#FLUX: -c=2
#FLUX: -t=428400
#FLUX: --priority=16

module load cuda/11.3
python3.9 prepare_image_data.py  /data/public/idd-segmentation/IDD_Segmentation/leftImg8bit  --out /no_backups/g013/data/IDD/lmdb_datasets/lmdb_v1_images_only --size 256
