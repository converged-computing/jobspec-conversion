#!/bin/bash
#FLUX: --job-name=blazor
#FLUX: -c=22
#FLUX: --queue=dl
#FLUX: -t=172800
#FLUX: --priority=16

conda deactivate
module load deeplearning/2.8.0
srun python driver.py & python driver_multilabel.py
