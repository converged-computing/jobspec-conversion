#!/bin/bash
#FLUX: --job-name=TriagingTuner
#FLUX: --queue=mpcg.p
#FLUX: -t=172800
#FLUX: --priority=16

module load hpc-env/8.3
module load Python/3.7.4-GCCcore-8.3.0
module load TensorFlow
python nn.py
