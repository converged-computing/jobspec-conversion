#!/bin/bash
#FLUX: --job-name=sticky-bicycle-9088
#FLUX: --priority=16

export PYTHONPATH='/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH'

export PYTHONPATH=/home1/08302/akshit06/ParaView-5.10.1-osmesa-MPI-Linux-Python3.9-x86_64/lib/python3.9/site-packages:$PYTHONPATH
ibrun python plot_tbl_main.py --parallel --data 'flat_plate.nek5000' --output 'frames1/test_q' --q-criterion --animate --view 1
