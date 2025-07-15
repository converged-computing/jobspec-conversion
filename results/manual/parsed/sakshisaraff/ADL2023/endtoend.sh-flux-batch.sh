#!/bin/bash
#FLUX: --job-name=coursework
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --priority=16

module purge
module add python
module load python
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
