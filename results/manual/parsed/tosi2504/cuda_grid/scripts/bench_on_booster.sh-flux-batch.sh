#!/bin/bash
#FLUX: --job-name=salted-kerfuffle-5327
#FLUX: --queue=develbooster
#FLUX: -t=7200
#FLUX: --priority=16

module purge
ml Stages/2024
module load GCCcore/.12.3.0
module load Python/3.11.3
ml NVHPC/23.7-CUDA-12
ml Meson/1.1.1
/p/software/juwelsbooster/stages/2024/software/Python/3.11.3-GCCcore-12.3.0/bin/python3 /p/home/jusers/sizmann1/juwels/phd/cuda_grid/benchmark/run.py
