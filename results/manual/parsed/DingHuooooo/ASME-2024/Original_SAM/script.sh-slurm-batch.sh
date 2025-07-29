#!/bin/bash
#FLUX: --job-name=MPI_JOB
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

source /home/mr634151/miniconda3/bin/activate
conda activate pytorch4sam
python UnetPlusSamPredictor.py
