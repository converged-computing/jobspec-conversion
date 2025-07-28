#!/bin/bash
#FLUX: --job-name=UQS37
#FLUX: -c=2
#FLUX: --queue=gpu_p2
#FLUX: -t=345599
#FLUX: --urgency=16

hostname
echo --------------------------------------
echo --------------------------------------
pwd
echo --------------------------------------
echo --------------------------------------
module purge
module load anaconda-py3
conda activate pytorch
CL_SOCKET_IFNAME=eno1 python train.py --data_dir /gpfsdswork/dataset/MUSDB18/ --ckpdir weights --cfg_path cfg.yaml
