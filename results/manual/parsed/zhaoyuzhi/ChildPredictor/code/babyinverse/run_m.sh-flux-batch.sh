#!/bin/bash
#FLUX: --job-name=start_imge
#FLUX: --priority=16

srun --mpi=pmi2 python -u main.py --config ./yaml/Inverse_ProGAN_GAN_MSGAN_ACGAN_start-with-image.yaml --mode train
