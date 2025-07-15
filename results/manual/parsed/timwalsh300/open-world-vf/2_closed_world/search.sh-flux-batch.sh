#!/bin/bash
#FLUX: --job-name=search_sirinam_vf_https_youtube
#FLUX: -c=8
#FLUX: --queue=barton
#FLUX: -t=86400
#FLUX: --priority=16

source /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/bin/activate /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/envs/tflow
python3 /home/timothy.walsh/VF/2_closed_world/search.py sirinam_vf https youtube
