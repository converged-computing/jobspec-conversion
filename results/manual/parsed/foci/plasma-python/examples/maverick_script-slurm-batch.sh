#!/bin/bash
#FLUX: --job-name=plasma-python
#FLUX: -n=20
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

module load gcc/4.9.3
module load python3/3.5.2
module load cuda/8.0
module load cudnn/5.1
module load tensorflow-gpu/1.0.0
module load mvapich2
module load git
ibrun python3 mpi_learn.py
