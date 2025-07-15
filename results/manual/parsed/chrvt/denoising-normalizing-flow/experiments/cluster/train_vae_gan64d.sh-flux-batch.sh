#!/bin/bash
#FLUX: --job-name=vae_gan64d
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments/benchmarks/vae
nvcc --version
nvidia-smi
python InfoMax_vae_gan64d.py
