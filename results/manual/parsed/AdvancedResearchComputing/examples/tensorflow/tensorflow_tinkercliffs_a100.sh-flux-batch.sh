#!/bin/bash
#FLUX: --job-name=goodbye-egg-5782
#FLUX: --priority=16

module reset
module load cuda11.2/toolkit #hopefully will be added to defaults soon
module load TensorFlow
echo "TENSORFLOW_TINKERCLIFFS_A100: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_TINKERCLIFFS_A100: Normal end of execution."
