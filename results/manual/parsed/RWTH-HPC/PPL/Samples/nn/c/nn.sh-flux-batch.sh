#!/bin/bash
#FLUX: --job-name=NN
#FLUX: -t=14400
#FLUX: --urgency=16

ml CUDA
echo; export; echo;  nvidia-smi; echo
nvcc -Xcompiler -fopenmp -o nn.out neural_network.cu -lcurand
for i in {1..40}
do
   ./nn.out
done
