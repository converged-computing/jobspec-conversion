#!/bin/bash
#FLUX: --job-name=chocolate-soup-3470
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=12000
#FLUX: --urgency=16

module load 2022
module load Python/3.10.4-GCCcore-11.3.0
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
conda activate maskblip
cd maskblip
python clustering_tuning.py
