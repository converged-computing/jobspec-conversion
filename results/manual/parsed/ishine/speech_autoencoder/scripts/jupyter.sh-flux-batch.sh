#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: --queue=bme_gpu
#FLUX: -t=432000
#FLUX: --priority=16

module load 7/compiler/cuda/11.4
source /hpc/data/home/bme/guochx/.bashrc
conda activate torch18
nvidia-smi
which python
srun jupyter notebook --no-browser --port=8888
