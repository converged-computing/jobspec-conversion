#!/bin/bash
#FLUX: --job-name=snakempi
#FLUX: -n=20
#FLUX: --queue=priority
#FLUX: --urgency=16

export TIMEFORMAT='user-seconds %3U'

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib"
export TIMEFORMAT="user-seconds %3U"
cd /home/pol02003/dub/mpitest
time mpirun -n 20 dubmpi
