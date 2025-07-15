#!/bin/bash
#FLUX: --job-name=Python_job
#FLUX: -t=6000
#FLUX: --priority=16

module purge
module load pytorch/python2.7/0.3.0_4
module load pytorch/python2.7/0.3.0_4
module load gcc/6.3.0
pip install torchwordemb --user
srun python train.py train.out
