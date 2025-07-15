#!/bin/bash
#FLUX: --job-name=schuster_vimeo_error_analysis
#FLUX: -c=4
#FLUX: --queue=beards
#FLUX: -t=21600
#FLUX: --urgency=16

source /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/bin/activate /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/envs/tflow
python3 /home/timothy.walsh/VF/2_closed_world/schuster_vimeo_error_analysis.py
