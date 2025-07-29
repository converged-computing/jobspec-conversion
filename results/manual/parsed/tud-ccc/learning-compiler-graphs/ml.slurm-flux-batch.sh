#!/bin/bash
#FLUX --job-name=chocolate-cattywampus-6056
#FLUX --queue=ml
#FLUX -t=86400
#FLUX --urgency=16

module load modenv/ml
module load TensorFlow
source ~/env/bin/activate && $@
