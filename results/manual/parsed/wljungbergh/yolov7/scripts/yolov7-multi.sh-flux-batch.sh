#!/bin/bash
#FLUX: --job-name=swampy-parrot-9779
#FLUX: --queue=ztestpreemp
#FLUX: -t=259200
#FLUX: --urgency=16

singularity exec --bind /datasets:/datasets --bind /staging:/staging --bind /workspaces:/workspaces \
    --nv \
    --pwd /workspaces/s0001387/repos/yolov7 \
    /staging/agp/geohe/containers/yolov7.sif \
    python -m torch.distributed.launch --nproc_per_node 8 --master_port 9527 train_aux.py --workers 8 --weights "weights/yolov7-e6_training.pt" --device 0,1,2,3,4,5,6,7 --batch-size 48 --sync-bn --data /workspaces/s0001387/repos/yolov7/data/zod_blur.yaml --nosave --img 1920 --cfg cfg/training/yolov7_zod.yaml --name zod-blur-e6-pretrain --hyp data/hyp.scratch.custom.yaml
