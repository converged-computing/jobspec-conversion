#!/bin/bash
#FLUX: --job-name=peachy-poo-0863
#FLUX: --priority=16

module load cuda/12.2.2  gcc/10.2   
nvidia-smi
nvcc -O2 src/main.cu
./a.out > out.ppm
python3 ./ppmtojpg.py
echo "done"
