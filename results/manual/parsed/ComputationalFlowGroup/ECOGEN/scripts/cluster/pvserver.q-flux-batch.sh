#!/bin/bash
#FLUX: --job-name=paraview
#FLUX: --queue=normal
#FLUX: --urgency=16

mpirun /home/kevinsch/software/ParaView-5.6.0-MPI-Linux-64bit/bin/pvserver --force-offscreen-rendering
