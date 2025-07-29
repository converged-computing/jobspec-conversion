#!/bin/bash
#SBATCH --job-name=vistest
#SBATCH --account=OTH21032
#SBATCH --output=slog
#SBATCH --error=serr
#SBATCH --mail-user=akshit@utexas.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

export PYTHONPATH='/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python plot_tbl_main.py --parallel --data 'flat_plate.nek5000' --output 'frames1/test_q' --q-criterion --animate --view 1
