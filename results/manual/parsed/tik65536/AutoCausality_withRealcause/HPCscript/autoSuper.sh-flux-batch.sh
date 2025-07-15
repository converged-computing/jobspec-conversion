#!/bin/bash
#FLUX: --job-name=swampy-salad-8692
#FLUX: -c=10
#FLUX: --queue=amd
#FLUX: --priority=16

module load python/3.8.6
cd $HOME/AutoML
python autocausality_AutoSuper.py
