#!/bin/bash
#FLUX: --job-name=neural_inf_data
#FLUX: --queue=week
#FLUX: --urgency=16

PROCESS=$1
module load Tools/miniconda
source activate py27
python ./build_training_set.py $PROCESS
