#!/bin/bash
#FLUX: --job-name=Fetal_brain_Trans-ventricular
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=252000
#FLUX: --urgency=16

export HOME='/scratch/st-sdena-1/miladyz'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source /scratch/st-sdena-1/miladyz/env_py3.8.10/bin/activate  
cd $SLURM_SUBMIT_DIR
pwd
nvidia-smi
export HOME="/scratch/st-sdena-1/miladyz"
python train_unconditional.py --class_ultra "Fetal brain_Trans-ventricular" --num_epochs 400
