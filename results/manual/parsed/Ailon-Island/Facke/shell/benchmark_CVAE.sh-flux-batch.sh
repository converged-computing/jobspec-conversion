#!/bin/bash
#FLUX: --job-name=evasive-citrus-5344
#FLUX: --urgency=16

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./benchmark.py --model CVAE --batchSize 32 --name CVAE
