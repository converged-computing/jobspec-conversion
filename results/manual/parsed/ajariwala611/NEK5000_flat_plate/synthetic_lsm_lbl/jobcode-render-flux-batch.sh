#!/bin/bash
#FLUX: --job-name=vistest
#FLUX: -N=8
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONPATH='/home1/05868/atsol/ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/05868/atsol/ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python plot_tbl_main.py --parallel --data 'flat_plate.nek5000' --output 'frames/q_criterion_view_4' --q-criterion --iso-u --animate --view 4
