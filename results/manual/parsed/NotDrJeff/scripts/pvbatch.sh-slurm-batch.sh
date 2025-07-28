#!/bin/bash
#FLUX: --job-name=pvbatch
#FLUX: -n=16
#FLUX: --queue=k2-medpri,medpri
#FLUX: -t=18000
#FLUX: --urgency=16

if [ -f $1 ]; then
    ~/OpenFOAM/ParaView-5.11.1/bin/mpiexec -n 16 ~/OpenFOAM/ParaView-5.11.1/bin/pvbatch "$@" 2>&1
fi
