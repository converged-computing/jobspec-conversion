#!/bin/bash
#FLUX: --job-name=chunky-citrus-5360
#FLUX: -n=6
#FLUX: --queue=amilan
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load intel
module load impi
module load valgrind/3.17.0
echo "=="
echo "||"
echo "|| Begin Execution of esPIC in slurm batch script."
echo "||"
echo "=="
srun -n 4 valgrind --tool=cachegrind --cachegrind-out-file="cachegrind.original.out" ./esPIC-original -nPEx 2 -nPEy 2 -nCellx 40 -nCelly 40 -nPtcl 100000  -flux 1000  -tEnd 1 -dt .01 -tPlot .2 -noPlot > original-cache.out
srun -n 4 valgrind --tool=callgrind --callgrind-out-file="callgrind.original.out" ./esPIC-original -nPEx 2 -nPEy 2 -nCellx 40 -nCelly 40 -nPtcl 100000  -flux 1000  -tEnd 1 -dt .01 -tPlot .2 -noPlot > original-call.out
callgrind_annotate --auto=yes cachegrind.original.out >  cachegrind.original.txt
echo "=="
echo "||"
echo "|| Execution of esPIC in slurm batch script complete."
echo "||"
echo "=="
