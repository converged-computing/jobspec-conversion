#!/bin/bash
#FLUX: --job-name=mpi_openmp_2node_%j
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=48
#FLUX: -t=115200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'

module purge
module load gcc/11.2.0
module load boost/1.78.0-release
module load cmake/3.22.0
module load hwloc/2.6.0
module load openmpi/4.1.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
echo "This script is used to run distributed MPI+OpenMP task bench 2 buran nodes, width 96 fixed width, from 2(6) to 2(24) "
date
for rn in {1..5..1}
do
	for i in {6..24..3}
	do
        	it=$((2 ** $i))
        	echo "using iter: "
        	echo ${it}
        	cd /work/nanmiao/taskbench/src/task-bench/mpi_openmp/
        	srun forall -type stencil_1d  -width 96 -steps 1000 -kernel compute_bound -iter ${it} 
        	echo "done iter =====================================  "
	done
done
echo "complete all runs"
date
