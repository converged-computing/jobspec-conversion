#!/bin/bash
#FLUX: --job-name=iFlow
#FLUX: -c=2
#FLUX: --queue=gpu_shared_course
#FLUX: -t=64800
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source activate iFlow-cuda
for seed in $(seq 1 100)
do
    python main.py \
        -x 1000_5_5_5_3_$seed'_'gauss_xtanh_u_f \
        -i iVAE \
        -ft RQNSF_AG \
        -npa Softplus \
        -fl 10 \
        -lr_df 0.25 \
        -lr_pn 10 \
        -b 64 \
        -e 20 \
        -l 1e-3 \
        -s 1 \
        -u 0 \
        -c 
done
