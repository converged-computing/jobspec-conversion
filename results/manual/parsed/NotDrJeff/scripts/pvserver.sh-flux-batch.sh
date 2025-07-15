#!/bin/bash
#FLUX: --job-name=pvserver
#FLUX: --queue=k2-medpri,medpri
#FLUX: -t=10800
#FLUX: --priority=16

module load apps/paraview/5.11.2
echo starting xvfb
xvfb-run echo \$DISPLAY
echo svfb finished
