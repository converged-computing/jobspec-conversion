#!/bin/bash
#FLUX: --job-name=c_g
#FLUX: --queue=Pixel
#FLUX: --urgency=16

srun --mpi=pmi2 python -u main.py --config ./yaml/Inverse_ProGAN_GAN_start-with-code.yaml --mode train
