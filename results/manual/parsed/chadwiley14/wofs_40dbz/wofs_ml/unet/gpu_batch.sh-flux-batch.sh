#!/bin/bash
#FLUX: --job-name=gpu_install
#FLUX: -n=4
#FLUX: --queue=ai2es
#FLUX: -t=1800
#FLUX: --priority=16

source /home/chadwiley/.bashrc
bash
conda activate tf
conda install -c conda-forge -y tensorflow==2.10.0=cuda112*
