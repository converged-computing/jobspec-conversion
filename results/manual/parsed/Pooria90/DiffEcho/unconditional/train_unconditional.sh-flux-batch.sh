#!/bin/bash
#FLUX: --job-name=<class_name>
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=72000
#FLUX: --priority=16

export HOME='<path to your new home>'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source <path to the virtualenv>/bin/activate  
cd $SLURM_SUBMIT_DIR
pwd
nvidia-smi
export HOME="<path to your new home>"
python train_unconditional.py --class_ultra "<class_name>" --num_epochs 400
