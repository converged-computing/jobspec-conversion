#!/bin/bash
#FLUX: --job-name=Regression
#FLUX: -t=21600
#FLUX: --urgency=16

WORKDIR=$HOME/thesis/train/trainer #main script
RUNDIR= #relative dir of config and output
SCRIPTNAME=main.py
CONFIG=config.py
PLOT_SCRIPT=plot.py
source $HOME/.zshrc
cd $WORKDIR
conda activate tf
python3 "$SCRIPTNAME" --outdir="$RUNDIR" --config="$CONFIG" #--plot_script="$PLOT_SCRIPT"
