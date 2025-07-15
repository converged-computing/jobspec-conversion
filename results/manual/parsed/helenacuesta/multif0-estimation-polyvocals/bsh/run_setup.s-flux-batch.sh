#!/bin/bash
#FLUX: --job-name=setup_v2
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load rubberband/intel/1.8.1
module load ffmpeg/intel/3.2.2
module load sox/intel/14.4.2
python 0_setup_fast.py
