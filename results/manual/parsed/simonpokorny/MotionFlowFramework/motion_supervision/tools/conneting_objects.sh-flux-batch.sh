#!/bin/bash
#FLUX: --job-name=nerdy-motorcycle-7423
#FLUX: -c=4
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

ml PyTorch3D/0.7.1-foss-2021b-CUDA-11.4.1
ml OpenCV/4.5.5-foss-2021b-CUDA-11.4.1-contrib
cd $HOME
python -u motion_supervision/run_test.py
