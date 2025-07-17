#!/bin/bash
#FLUX: --job-name=expensive-bike-3651
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity exec --nv --bind /blue/vendor-nvidia/hju/data/BTCV:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--logdir=/mnt \
--data_dir=/mnt --json_list=dataset_0.json \
--roi_x=96 --roi_y=96 --roi_z=96 --feature_size=48 \
--batch_size=1 \
--val_every=1 --max_epochs=2 \
--save_checkpoint \
--noamp
