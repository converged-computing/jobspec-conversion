#!/bin/bash
#FLUX: --job-name=conspicuous-cinnamonbun-8682
#FLUX: --urgency=16

module load cuda/12.2.2  gcc/10.2   
nvidia-smi
nvcc -O2 src/main.cu
./a.out > out.ppm
python3 ./ppmtojpg.py
echo "done"
