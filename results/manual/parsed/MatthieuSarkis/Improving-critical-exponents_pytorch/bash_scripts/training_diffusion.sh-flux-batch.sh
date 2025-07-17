#!/bin/bash
#FLUX: --job-name=diffusion_ising
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

ulimit -s unlimited
export OMP_NUM_THREADS=1
module load lang/Python/3.8.6-GCCcore-10.2.0
. /home/users/msarkis/git_repositories/Improving-critical-exponents_pytorch/.env/bin/activate
module load toolchain/intel
python src/denoising-diffusion-pytorch/train.py
