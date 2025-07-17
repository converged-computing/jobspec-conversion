#!/bin/bash
#FLUX: --job-name=h2o_arrayJob
#FLUX: --queue=development
#FLUX: -t=7200
#FLUX: --urgency=16

source ~/conda.init
conda activate h2oai
srun python h2o_randomForest.py
