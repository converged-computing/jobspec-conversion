#!/bin/bash
#FLUX: --job-name=nas        ## Name of the job
#FLUX: -c=8
#FLUX: --queue=gpu ##GPU run
#FLUX: -t=86399
#FLUX: --priority=16

source ~/.bashrc
conda deactivate
conda activate new
module load python
srun python nas.py
