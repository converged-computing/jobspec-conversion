#!/bin/bash
#FLUX: --job-name="miniproject"
#FLUX: -c=32
#FLUX: --queue=GPUQ
#FLUX: -t=86400
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}/yolov7
module purge
module load Python/3.8.6-GCCcore-10.2.0
pip install -r requirements.txt --user -q
pip install wandb --user -q
wandb login "ef4c5c0b5b612d591e12bfd25fb32fad417d60e5"
python3 -m torch.distributed.launch --nproc_per_node=2 train.py --batch 30 --epochs 300 --data data/data_norway_japan_usa.yaml --weights yolov7_training.pt --device 0,1 --workers 8 --img 1280 1280 --cfg cfg/training/yolov7.yaml --hyp data/hyp.scratch.custom.yaml
