#!/bin/bash
#SBATCH --job-name=Monojets
#SBATCH --account=
#SBATCH --output=output_%J.log
#SBATCH --error=error_%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=03:40:00

WORKDIR=$HOME/thesis/train/trainer #main script
RUNDIR= #relative dir of config and output
SCRIPTNAME=main.py
CONFIG=config.py
PLOT_SCRIPT=plot.py
source $HOME/.zshrc
cd $WORKDIR
conda activate tf
python3 "$SCRIPTNAME" --outdir="$RUNDIR" --config="$CONFIG" --plot_script="$PLOT_SCRIPT"
