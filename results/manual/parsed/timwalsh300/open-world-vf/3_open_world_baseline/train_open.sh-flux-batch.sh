#!/bin/bash
#FLUX: --job-name=train_open_dschuster16_tor
#FLUX: -c=2
#FLUX: --queue=barton
#FLUX: -t=86400
#FLUX: --urgency=16

source /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/bin/activate /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/envs/tflow
python3 /home/timothy.walsh/VF/3_open_world_baseline/train_open.py
