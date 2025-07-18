#!/bin/bash
#FLUX: --job-name=hpx-plainmpi-join-8node-%j
#FLUX: --queue=buran
#FLUX: -t=600
#FLUX: --urgency=16

module load gcc/11.2.0
module load boost/1.78.0-release
module load cmake/3.22.0
module load hwloc/2.6.0
module load pmix/4.1.0
module load openmpi/4.1.2
echo "This script is used to run distributed HPX (plain MPI + fork join executor) task bench 8 buran nodes, width 384 fixed width, from 2(6) to 2(24) "
date
for rn in {1..5..1}
do
	for i in {6..24..3}
	do
        	it=$((2 ** $i))
        	echo "using iter: "
        	echo ${it}
        	cd /work/nanmiao/taskbench/src/task-bench/hpx/build_Release/bin/
        	srun -N 8 -n 8 -c 48 mpi_executor -type stencil_1d  -width 384 -steps 1000 -kernel compute_bound -iter ${it} --hpx:threads=48
        	echo "done iter =====================================  "
        	date
	done
done
echo "complete all runs"
date
