#!/bin/bash
#FLUX: --job-name=RD_AFR
#FLUX: -t=561600
#FLUX: --urgency=16

module load tensorflow/1.6.0-py36-gpu
module load python/3.6.1
module load opencv/3.2.0
cd /scratch1/wan246/DRainDrop/AFR_Net/RD_AFR
python main.py
