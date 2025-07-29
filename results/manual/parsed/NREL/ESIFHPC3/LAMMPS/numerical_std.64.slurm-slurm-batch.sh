#!/bin/bash
#FLUX: --job-name=lmp.std2
#FLUX: -N=2
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module purge
module use /nopt/nrel/apps/modules/centos77/modulefiles/
module load intel-mpi/2020.1.217 mkl/2020.1.217 
module list
export OMP_NUM_THREADS=1
taskpernode=32
ntasks=$((SLURM_JOB_NUM_NODES*taskpernode))
run_cmd="srun --ntasks $ntasks --tasks-per-node=$taskpernode"
lmp_path=/nopt/nrel/apps/lammps/3Mar20-centos77/bin/lmp
input_path=../input
run_name=(medium_numerical_test)
echo Run $ntasks MPI ranks without GPU
for name in "${run_name[@]}"
do
	echo Run $name 
	cp $input_path/$name.in .
	time $run_cmd $lmp_path -in $name.in >& $name.log
	../validate.sh $name.log ../NREL_results	
done
