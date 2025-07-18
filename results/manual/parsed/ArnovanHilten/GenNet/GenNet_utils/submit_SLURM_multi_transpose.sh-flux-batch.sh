#!/bin/bash
#FLUX: --job-name=gassy-platanos-7757
#FLUX: -n=6
#FLUX: --queue=short
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load Python/3.7.4-GCCcore-8.3.0
module load libs/cuda/10.1.243
module load libs/cudnn/7.6.5.32-CUDA-10.1.243
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
source $HOME/venv_GenNet_37/bin/activate
python ./GenNet_utils/Convert.py -job_begins $1 -job_tills $2 -job_n $3 -study_name $4 -outfolder $5 -tcm $6
