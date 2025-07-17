#!/bin/bash
#FLUX: --job-name=generation-unconditional
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

export HOME='<path to your new home>'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source <path to the virtualenv>/bin/activate  
cd $SLURM_SUBMIT_DIR
pwd
nvidia-smi
export HOME="<path to your new home>"
python data_generation.py --number_of_images 800
