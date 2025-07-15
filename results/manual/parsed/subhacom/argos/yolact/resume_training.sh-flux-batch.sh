#!/bin/bash
#FLUX: --job-name=reclusive-avocado-4459
#FLUX: -c=32
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module load CUDA/10.1
module load cuDNN/7.6.5/CUDA-10.1
module load gcc
pushd /data/rays3/locust_tracking/yolact
python train.py --config=babylocust_config --resume=weights/babylocust_resnet101_25999_78000.pth --start_iter=-1 --batch_size=8 --save_interval=1000 --keep_latest 
echo "Finished training"
popd
