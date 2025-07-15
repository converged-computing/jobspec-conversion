#!/bin/bash
#FLUX: --job-name=qed
#FLUX: -c=36
#FLUX: -t=3600
#FLUX: --urgency=16

module load cudnn/8.1.1/cuda-11.2
conda activate graphenv
python run_qed.py
