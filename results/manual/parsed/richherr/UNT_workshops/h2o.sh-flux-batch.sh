#!/bin/bash
#FLUX: --job-name=h2o_arrayJob
#FLUX: --priority=16

source ~/conda.init
conda activate h2oai
srun python h2o_randomForest.py
