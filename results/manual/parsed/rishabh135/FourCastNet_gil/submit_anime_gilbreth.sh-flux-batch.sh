#!/bin/bash
#FLUX: --job-name=fourcastnet_job
#FLUX: -t=82800
#FLUX: --urgency=16

export PRECXX11ABI='1'
export CUDA='11.7'

module --force purge
unset PYTHONPATH
module load anaconda/5.3.1-py37
module load cuda/11.7.0
module load cudnn/cuda-11.7_8.6
module use /depot/gdsp/etc/modules
module load utilities monitor
module load rcac
module list
export PRECXX11ABI=1
export CUDA="11.7"
echo $PYTHONPATH
source  /apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/etc/profile.d/conda.sh
conda activate pytorch
cd /scratch/gilbreth/wwtung/FourCastNet/
python /scratch/gilbreth/gupt1075/FourCastNet/animate_input.py
