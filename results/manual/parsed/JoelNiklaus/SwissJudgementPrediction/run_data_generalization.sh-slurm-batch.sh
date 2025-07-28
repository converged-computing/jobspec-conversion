#!/bin/bash
#FLUX: --job-name=Data Generalization
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate data_aug
python -m data_generalization.date_normalizer
