#!/bin/bash
#FLUX: --job-name=YOLOv5 Training for sheep recognition
#FLUX: --queue=GPUQ
#FLUX: -t=601200
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
wandb online
python train.py --img 1280 --batch 8 --epochs 1000 --data sheep-cropped-no-msx.yaml --weights yolov5l6.pt --cache --device 0
