#!/bin/bash
#FLUX: --job-name=doopy-omelette-5411
#FLUX: -n=6
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --urgency=16

module load python/gcc-8.2.0/3.7.6
module load cuda10.1/toolkit/10.1.105
module load cuda10.1/blas/10.1.105
module load eigen/gcc-8.2.0/3.3.7
source /home/cdmiller/damnn/bin/activate
python3 /home/cdmiller/damNN-vslam/damnn_vslam_vo_only.py
