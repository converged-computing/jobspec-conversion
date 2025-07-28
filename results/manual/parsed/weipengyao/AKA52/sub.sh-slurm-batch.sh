#!/bin/bash
#FLUX: --job-name=aka_stream_test0
#FLUX: -t=86399
#FLUX: --urgency=16

PROGRAM=/home/a/anticipa/weipeng/CODES/AKA52/aka.exe
SOURCE=/home/a/anticipa/weipeng/CODES/AKA52/compile_aka52_niagara.sh
NPROC=32 # Note: nodes x ntasks-per-node(=40)
NAMELIST=/home/a/anticipa/weipeng/CODES/AKA52/input/
source $SOURCE
mpirun -n $NPROC $PROGRAM  $NAMELIST
