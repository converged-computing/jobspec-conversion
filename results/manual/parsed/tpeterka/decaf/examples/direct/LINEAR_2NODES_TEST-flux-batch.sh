#!/bin/bash
#FLUX: --job-name=gassy-arm-5090
#FLUX: --priority=16

ARCH=LINUX
num_procs=8
ppn=1 # adjustable for BG/Q, allowed 1, 2, 4, 8, 16, 32, 64
num_nodes=$[$num_procs / $ppn]
if [ $num_nodes -lt 1 ]; then
    num_nodes=1
fi
exe=./linear_2nodes
if [ "$ARCH" = "MAC_OSX" ]; then
mpiexec -l -n $num_procs $exe
fi
if [ "$ARCH" = "LINUX" ]; then
mpiexec -n $num_procs $exe
fi
if [ "$ARCH" = "BGQ" ]; then
qsub -n $num_nodes --env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:DECAF_PREFIX=$DECAF_PREFIX --mode c$ppn -A SDAV -t 60 $exe
fi
if [ "$ARCH" = "EDISON" ]; then
srun -n $num_procs $exe
fi
if [ "$ARCH" = "CORI" ]; then
srun -C haswell -n $num_procs $exe
fi
if [ "$ARCH" = "TITAN" ]; then
cd /ccs/proj/csc242/decaf/install/examples/direct
date
aprun -n $num_procs $exe
fi
