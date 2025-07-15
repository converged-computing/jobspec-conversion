#!/bin/bash
#FLUX: --job-name=peachy-poodle-2886
#FLUX: -t=259200
#FLUX: --urgency=16

module load TensorFlow/2.11.0-foss-2022a
python FractalModelSlurm.py
module unload TensorFlow/2.11.0-foss-2022a
module load Anaconda3
python PrintPlots.py fractal_GHMSS_v1.out
module unload Anaconda3
