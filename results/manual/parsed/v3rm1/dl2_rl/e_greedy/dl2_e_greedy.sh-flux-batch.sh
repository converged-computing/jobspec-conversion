#!/bin/bash
#FLUX: --job-name=dl2_e_greedy_pong
#FLUX: --queue=gpu
#FLUX: -t=252000
#FLUX: --urgency=16

module load Python/3.6.4-foss-2018a
module load CUDA/9.1.85
module load Boost/1.66.0-foss-2018a-Python-3.6.4
module load TensorFlow/1.12.0-fosscuda-2018a-Python-3.6.4
python ./pong.py
mv *.out slurm/
