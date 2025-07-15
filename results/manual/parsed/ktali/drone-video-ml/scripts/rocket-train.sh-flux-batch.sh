#!/bin/bash
#FLUX: --job-name=hairy-milkshake-5924
#FLUX: --queue=gpu
#FLUX: --priority=16

module load cuda/10.2.89-2fkd
source ../torchenv/bin/activate
python train.py --data data/person-coco.data --cfg cfg/yolov3-tiny-1cls.cfg --weights=weights/last.pt --single-cls --batch-size 42 --epochs 20
