#!/bin/bash
#FLUX: --job-name=psycho-bike-7030
#FLUX: -c=24
#FLUX: --queue=amdgpuextralong
#FLUX: -t=864000
#FLUX: --urgency=16

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python train_uda.py configs/data_config/da_kitti_nuscenes/uda_kitti_nuscenes_f0_0_time.yaml --distributed False --ssl False
