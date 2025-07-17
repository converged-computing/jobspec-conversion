#!/bin/bash
#FLUX: --job-name=stemgen
#FLUX: -c=4
#FLUX: --queue=dgx2
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.10 cuda/11.7 sox
source env/bin/activate
python train_model.py
