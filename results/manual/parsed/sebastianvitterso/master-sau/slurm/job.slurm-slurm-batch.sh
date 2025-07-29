#!/bin/bash
#FLUX: --job-name=YOLOv5 Training for sheep recognition
#FLUX: --queue=GPUQ
#FLUX: -t=540000
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
pip freeze --user | xargs pip uninstall -y
module purge
module load fosscuda/2020b
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd yolov5
pwd
pip install -r requirements.txt --no-cache-dir
python train.py --img 1280 --batch 6 --epochs 300 --data sheep-partitioned.yaml --weights '' --cfg yolov5l6.yaml --cache --device 0
