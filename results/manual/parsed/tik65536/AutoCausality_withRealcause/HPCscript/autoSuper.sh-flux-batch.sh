#!/bin/bash
#FLUX: --job-name=adorable-soup-7308
#FLUX: -c=10
#FLUX: --queue=amd
#FLUX: --urgency=16

module load python/3.8.6
cd $HOME/AutoML
python autocausality_AutoSuper.py
