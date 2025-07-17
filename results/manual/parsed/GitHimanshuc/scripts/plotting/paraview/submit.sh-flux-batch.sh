#!/bin/bash
#FLUX: --job-name=pvpython
#FLUX: -t=3600
#FLUX: --urgency=16

/panfs/ds09/sxs/himanshu/softwares/ParaView-5.10.0-osmesa-MPI-Linux-Python3.9-x86_64/bin/pvpython /panfs/ds09/sxs/himanshu/scripts/plotting/paraview/load_and_take_slice.py
