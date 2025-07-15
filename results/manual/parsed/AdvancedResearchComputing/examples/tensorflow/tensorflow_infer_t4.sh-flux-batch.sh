#!/bin/bash
#FLUX: --job-name=strawberry-ricecake-5919
#FLUX: --priority=16

module reset
module load TensorFlow
echo "TENSORFLOW_INFER_T4: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_INFER_T4: Normal end of execution."
