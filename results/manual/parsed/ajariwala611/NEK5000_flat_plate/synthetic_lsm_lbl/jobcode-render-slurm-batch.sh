#!/bin/bash
#SBATCH --job-name=vistest
#SBATCH --account=OTH21032
#SBATCH --output=slog
#SBATCH --error=serr
#SBATCH --mail-user=atsolovikos@gmail.com
#SBATCH --mail-type=all
#SBATCH --nodes=8
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=normal

export PYTHONPATH='/home1/05868/atsol/ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/05868/atsol/ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python plot_tbl_main.py --parallel --data 'flat_plate.nek5000' --output 'frames/q_criterion_view_4' --q-criterion --iso-u --animate --view 4
