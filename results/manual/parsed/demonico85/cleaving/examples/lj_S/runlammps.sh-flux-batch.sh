#!/bin/bash
#FLUX: --job-name=ljbulk
#FLUX: --queue=compute
#FLUX: -t=360000
#FLUX: --priority=16

module purge
module load gcc/6.3.0/1 openmpi/3.0.1/01 
lmp="./lmp_mpi"
    rm -r ./dump/ 2> /dev/null
    rm -r ./restart/ 2> /dev/null
    mkdir dump
    mkdir restart
mpirun -np 28 $lmp  < bulk.in 
exit $?
