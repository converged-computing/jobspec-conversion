#!/bin/bash
#FLUX: --job-name=arid-taco-3319
#FLUX: --queue=t4_dev_q
#FLUX: -t=600
#FLUX: --urgency=16

module reset
module load TensorFlow
echo "TENSORFLOW_INFER_T4: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_INFER_T4: Normal end of execution."
