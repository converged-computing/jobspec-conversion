#!/bin/bash
#FLUX: --job-name=cp
#FLUX: --queue=gpu
#FLUX: -t=6000
#FLUX: --urgency=16

date
source /opt/easybuild/software/Anaconda3/2019.07/etc/profile.d/conda.sh
conda init bash
conda activate tasks-pip
rm -r tmp_out
python run_example_cellpose.py
date
