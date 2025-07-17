#!/bin/bash
#FLUX: --job-name=fourcastnet_job
#FLUX: -t=3600
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
echo "$now"
echo "Current date completed loading modules: $now"
source  /apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/etc/profile.d/conda.sh
conda activate pytorch
python /scratch/gilbreth/gupt1075/FourCastNet_gil/inference/inference.py \
       --config="afno_backbone" \
       --run_num="222" \
       --fld="z500" \
       --weights="/scratch/gilbreth/wwtung/FourCastNet/model_weights/FCN_weights_v0/backbone.ckpt"  \
       --exp_dir="/scratch/gilbreth/gupt1075/ERA5_expts_tutorial/"
