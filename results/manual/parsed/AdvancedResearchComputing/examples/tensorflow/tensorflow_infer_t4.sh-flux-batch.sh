#!/bin/bash
#FLUX: --job-name=hello-peas-0772
#FLUX: --urgency=16

module reset
module load TensorFlow
echo "TENSORFLOW_INFER_T4: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_INFER_T4: Normal end of execution."
