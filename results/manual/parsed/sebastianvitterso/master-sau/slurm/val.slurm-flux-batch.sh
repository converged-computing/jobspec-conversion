#!/bin/bash
#FLUX: --job-name="YOLOv5 Validation for sheep recognition"
#FLUX: --queue=GPUQ
#FLUX: -t=601200
#FLUX: --priority=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
FOLDER="rgb-small-no-msx"
python val.py --weights "runs/train/$FOLDER/weights/best.pt" --img 1280 --save-txt --save-conf --data sheep-cropped-no-msx.yaml --name $FOLDER
