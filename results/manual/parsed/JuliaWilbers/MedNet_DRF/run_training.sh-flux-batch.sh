#!/bin/bash
#FLUX: --job-name=goodbye-puppy-2066
#FLUX: --queue=short
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load Python/3.7.2-GCCcore-8.2.0
source "/trinity/home/jwilbers/MedNet/MedicalNet/venv_mednet_2/bin/activate"
python train.py --gpu_id 0 --batch_size 1 --num_workers 1 --model_depth 10 --pretrain_path pretrain/resnet_10.pth 
