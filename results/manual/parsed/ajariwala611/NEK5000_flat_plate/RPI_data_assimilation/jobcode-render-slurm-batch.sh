#!/bin/bash
#SBATCH --job-name=vistest
#SBATCH --account=OTH21032
#SBATCH --output=slog
#SBATCH --error=serr
#SBATCH --mail-user=akshit@utexas.edu
#SBATCH --mail-type=end
#SBATCH --nodes=8
#SBATCH --ntasks=83
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=normal

export PYTHONPATH='/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python write_csv.py --parallel --data 'flat_plate.nek5000' --output 'slice_6D/slice_Re_6365' --slice1 --animate --view 1
