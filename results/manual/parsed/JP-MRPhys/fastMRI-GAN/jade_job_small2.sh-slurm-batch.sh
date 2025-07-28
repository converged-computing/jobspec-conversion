#!/bin/bash
#FLUX: --job-name=vqvae
#FLUX: --queue=devel
#FLUX: --urgency=16

module load python3/anaconda
source activate tensorflow2-gpu
python ./model/VQVAE1.py
