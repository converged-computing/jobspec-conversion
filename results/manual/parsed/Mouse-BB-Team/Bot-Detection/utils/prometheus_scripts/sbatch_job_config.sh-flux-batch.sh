#!/bin/bash
#FLUX: --job-name=swampy-banana-9023
#FLUX: -t=93600
#FLUX: --priority=16

module add plgrid/tools/python/3.8
module add plgrid/libs/tensorflow-gpu/2.3.1-python-3.8
module add plgrid/apps/cuda/10.1
cd $SLURM_SUBMIT_DIR
cd ../..
pip install -r requirements.txt
python3 main.py -d "/net/archive/groups/plggpchdyplo/augmented_data/"
