#!/bin/bash
#FLUX: --job-name=ProGAN
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

ulimit -s unlimited
export OMP_NUM_THREADS=1
module load lang/Python
. /home/users/msarkis/git_repositories/Improving-critical-exponents_pytorch/.env/bin/activate
module load toolchain/intel
python src/progan/main.py --max_image_size 8
