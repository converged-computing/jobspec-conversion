#!/bin/bash
#FLUX: --job-name=WaterLily
#FLUX: -c=12
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load 2022r2
module load cuda/11.6
time julia TwoD_circle.jl
