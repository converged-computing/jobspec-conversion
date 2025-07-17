#!/bin/bash
#FLUX: --job-name=regnn57
#FLUX: --queue=general
#FLUX: -t=32400
#FLUX: --urgency=16

module load miniconda
source activate /N/slate/mraina/egnn/
cd /N/slate/mraina/REGNN/
python calculate_ARI.py
