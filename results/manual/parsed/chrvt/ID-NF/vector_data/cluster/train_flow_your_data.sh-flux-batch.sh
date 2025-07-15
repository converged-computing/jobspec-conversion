#!/bin/bash
#FLUX: --job-name="My_data"
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

cd /storage/homefs/ch19g182/Python/ID-NF/estimate_d
nvcc --version
nvidia-smi
python my_vector_data_cluster.py --sig2_min 1e-09 --sig2_max 10 --n_sigmas 20 --dataset my_data --data_dim 3 --hidden_dim 210 --N_epochs 500 --batch_size 200 --ID_samples 100
