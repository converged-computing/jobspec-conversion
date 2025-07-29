#!/bin/bash
#SBATCH --job-name=xterm
#SBATCH --account=adamginsburg
#SBATCH --output=xterm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=adamginsburg

date; hostname; pwd;
unset XDG_RUNTIME_DIR
module purge; module load gui/2 xterm
/apps/gui/2.0.0/bin/start_gui_app xterm
date
