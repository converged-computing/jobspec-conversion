#!/bin/bash
#FLUX: --job-name=mcmcprobsat
#FLUX: --urgency=16

echo "$ run.sh $@"
date
([ -f "main.cpp" ]) || (echo "wrong directory" && exit)
echo "preparing environment & load modules"
module list
[ $(module list compiler/gnu/11.1 2>&1 |grep -ci "None found") == 1 ] && echo "loading gnu compiler 11.1" && module load compiler/gnu/11.1
[ $(module list mpi/openmpi/default 2>&1 |grep -ci "None found") != 1 ] && echo "unload default openmpi" && module unload mpi/openmpi/default
[ $(module list mpi/openmpi/4.1 2>&1 |grep -ci "None found") != 1 ] && echo "unload openmpi 4.1" && module unload mpi/openmpi/4.1
[ $(module list compiler/gnu/11.1 2>&1 |grep -ci "None found") == 1 ] && echo "loading gnu compiler 11.1" && module load compiler/gnu/11.1
[ $(module list mpi/openmpi/4.1 2>&1 |grep -ci "None found") == 1 ] && echo "loading openmpi 4.1" && module load mpi/openmpi/4.1
[ $(module list devel/cmake/3.18 2>&1 |grep -ci "None found") == 1 ] && echo "loading cmake 3.18" && module load devel/cmake/3.18
module list
g++ --version |head -1
echo "building"
([ -f "main" ]) || (mpic++ -I "bitsery/include/" -O2 -std=c++20 -Wall -Wextra -o main main.cpp)
([ -f "main" ]) || (echo "fatal: build error! exit now" && exit)
outfile="$1"
([ -f $outfile ]) && (echo "output file already exists!") && exit
shift 1
echo "running"
date
(mpirun --mca pml ^ucx --mca mpi_warn_on_fork 0 --bind-to core --map-by core main $@ &> $outfile) || echo ""
echo "done."
