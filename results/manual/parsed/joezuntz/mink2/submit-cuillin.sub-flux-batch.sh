#!/bin/bash
#FLUX: --job-name=bricky-avocado-1689
#FLUX: -c=4
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='4'

cd $HOME/mink2
export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=4
if [ ! -f mink-latest.simg ]; then
    singularity pull docker://joezuntz/mink:latest
fi
singularity run  ./mink-latest.simg ./run-cuillin.sh
