#!/bin/bash
#FLUX: --job-name=gpus
#FLUX: -c=2
#FLUX: --queue=yolo
#FLUX: --urgency=16

source activate /mnt/beegfs/work/zhang/conda/dragon
module purge
module load cuda/11.0 # you can change the cuda version
nvidia-smi
