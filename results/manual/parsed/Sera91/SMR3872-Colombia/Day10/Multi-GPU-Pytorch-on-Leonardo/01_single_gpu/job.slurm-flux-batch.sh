#!/bin/bash
#FLUX: --job-name=mnist
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load gcc
module load cuda
module load openmpi
source $HOME/.bashrc
conda activate /leonardo_work/ICT23_SMR3872/shared-env/Gabenv
kernprof -l mnist_classify.py --epochs=3
