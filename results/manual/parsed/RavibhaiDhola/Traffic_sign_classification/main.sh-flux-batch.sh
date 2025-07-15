#!/bin/bash
#FLUX: --job-name=nas
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

source ~/.bashrc
conda deactivate
conda activate new
module load python
srun python nas.py
