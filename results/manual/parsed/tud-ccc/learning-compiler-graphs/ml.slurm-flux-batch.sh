#!/bin/bash
#FLUX: --job-name=boopy-diablo-5362
#FLUX: --queue=ml
#FLUX: -t=86400
#FLUX: --priority=16

module load modenv/ml
module load TensorFlow
source ~/env/bin/activate && $@
