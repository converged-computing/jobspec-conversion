#!/bin/bash
#FLUX: --job-name=expensive-egg-6549
#FLUX: -t=3600
#FLUX: --priority=16

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
conda activate /home/gupt1075/.conda/envs/cent7/5.3.1-py37/pytorch
python /scratch/gilbreth/gupt1075/FourCastNet/inference/inference.py \
       --config="afno_backbone" \
       --run_num="02" \
       --fld="t850" \
       --weights="/scratch/gilbreth/gupt1075/model_weights/FCN_weights_v0/backbone.ckpt"  \
       --override_dir="/scratch/gilbreth/gupt1075/ERA5_expts_2m_temperature_trial_1/"
