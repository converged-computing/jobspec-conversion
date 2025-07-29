#!/bin/bash
#FLUX: --job-name=vistest
#FLUX: -N=8
#FLUX: -n=83
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

export PYTHONPATH='/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python write_csv.py --parallel --data 'flat_plate.nek5000' --output 'slice_6D/slice_Re_6365' --slice1 --animate --view 1
