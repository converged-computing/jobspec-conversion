#!/bin/bash
#FLUX: --job-name=angry-malarkey-7552
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity exec --nv --bind /blue/vendor-nvidia/hju/data/BraTS2021:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--json_list=/mnt/brats21_folds.json --data_dir=/mnt \
--roi_x=128 --roi_y=128 --roi_z=128 --in_channels=4 --spatial_dims=3 \
--feature_size=48 \
--val_every=1 --max_epochs=2 \
--use_checkpoint --noamp --save_checkpoint
