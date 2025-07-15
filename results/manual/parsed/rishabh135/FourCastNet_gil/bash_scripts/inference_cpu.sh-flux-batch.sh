#!/bin/bash
#FLUX: --job-name=dirty-cherry-9877
#FLUX: -t=7200
#FLUX: --urgency=16

export PRECXX11ABI='1'

module --force purge
unset PYTHONPATH
module load anaconda/5.3.1-py37
module use /depot/gdsp/etc/modules
module load utilities monitor
module load rcac
module list
export PRECXX11ABI=1
echo $PYTHONPATH
echo "$now"
echo "Current date completed loading modules: $now"
source  /apps/spack/gilbreth/apps/anaconda/5.3.1-py37-gcc-4.8.5-7vvmykn/etc/profile.d/conda.sh
conda activate pytorch
python /scratch/gilbreth/gupt1075/FourCastNet/inference/inference.py \
       --config='afno_backbone' \
       --run_num='02' \
       --weights="/scratch/gilbreth/gupt1075/model_weights/FCN_weights_v0/backbone.ckpt"  \
       --override_dir="/scratch/gilbreth/gupt1075/ERA5_expts_22_feb_2018_v10_trial_1/" \
       --fld="v10"
