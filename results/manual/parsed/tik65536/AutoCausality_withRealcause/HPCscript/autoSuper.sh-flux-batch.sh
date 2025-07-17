#!/bin/bash
#FLUX: --job-name=Super
#FLUX: -c=10
#FLUX: --queue=amd
#FLUX: -t=89100
#FLUX: --urgency=16

module load python/3.8.6
cd $HOME/AutoML
python autocausality_AutoSuper.py
