#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=secondary-eth
#FLUX: -t=14400
#FLUX: --priority=16

module load anaconda/2023-Mar/3
module load cuda/11.7
nvcc --version
nvidia-smi
source activate pytorch_one
python Ising_seed.py ${SLURM_ARRAY_TASK_ID}
