#!/bin/bash
#FLUX: --job-name=reclusive-animal-8802
#FLUX: -c=8
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

export TF_CPP_MIN_LOG_LEVEL='2'

module purge 
source /share/apps/NYUAD/miniconda/3-4.11.0/bin/activate
conda activate tf-env2
export TF_CPP_MIN_LOG_LEVEL="2"
python main.py "../DatabaseV2/TrainSet" "../DatabaseV2/TestSet"
