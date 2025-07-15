#!/bin/bash
#FLUX: --job-name=groundgan
#FLUX: -c=4
#FLUX: --queue=booster
#FLUX: -t=86400
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
export CUDA_VISIBLE_DEVICES=0,1,2,3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
source /p/project/hai_fedak/teju/GRouNdGAN/activate.sh
cd /p/project/hai_fedak/teju/GRouNdGAN
srun --exclusive python src/main.py --config /p/project/hai_fedak/teju/GRouNdGAN/configs/causal_gan.cfg --train&
wait
