#!/bin/bash
#FLUX: --job-name=MPI_JOB
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

source /home/ai773056/anaconda3/bin/activate
conda activate pytorch4sam
python UnetPredictor.py
