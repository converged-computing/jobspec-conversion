#!/bin/bash
#FLUX: --job-name=hello-lemon-6066
#FLUX: -t=32400
#FLUX: --priority=16

module load miniconda
source activate /N/slate/mraina/egnn/
cd /N/slate/mraina/REGNN/
python calculate_ARI.py
