#!/bin/bash
#FLUX: --job-name=confused-diablo-3732
#FLUX: --queue=dcs-gpu
#FLUX: -t=38400
#FLUX: --urgency=16

export CXX='g++'

nvidia-smi
module load Anaconda3/2019.07
module load CUDA/10.2.89-GCC-8.3.0 # includes GCC 8.3 CUDA 10.2
source activate ML
export CXX=g++
torchrun --nnodes=1 --nproc_per_node=4 --standalone main.py --data_path ../data/ --audio_path ../data/ --data_csv_path ../data/ --data_csv_path ../data/Legasee.csv --ckpt ./checksaves/external_end_3/checkpoint.pt
