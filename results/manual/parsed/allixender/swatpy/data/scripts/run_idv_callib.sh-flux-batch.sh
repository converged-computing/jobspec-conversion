#!/bin/bash
#FLUX: --job-name=salted-poo-1139
#FLUX: --urgency=16

module load python-3.7.1
source activate daskgeo2020a
$HOME/.conda/envs/daskgeo2020a/bin/python run_for.py -m $MD1 -s $SP1 -r $REP1 -p $PAR1
