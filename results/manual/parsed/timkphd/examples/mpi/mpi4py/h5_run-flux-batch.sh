#!/bin/bash
#FLUX: --job-name=mpi4py
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

mkdir $SLURM_JOBID
cat $0 > $SLURM_JOBID/script
date
module purge
for TEST in h5b dompt dointel ; do
	LIB_SAVE=$LD_LIBRARY_PATH
	if [ $TEST == "h5b" ] ; then
		module load conda
		source activate dompi
		module load intel-mpi/2020.1.217
	fi
	if [ $TEST == "dompt" ] ; then
		module load mpt/2.22 gcc/8.4.0 
		export LD_LIBRARY_PATH=/projects/hpcapps/tkaiser/hdf5_12_03/lib:$LD_LIBRARY_PATH
	fi
	if [ $TEST == "dointel" ] ; then
		module load intel-mpi/2020.1.217 hdf5/1.12.0/intel-impi
	fi
	echo $TEST
	printenv | grep SLURM
	ml
	rm -rf parallel_test.hdf5
	export SUB=0
	srun   ./$TEST -size=64M -count=1 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	rm -rf parallel_test.hdf5
	export SUB=1
	srun   ./$TEST -size=64M -count=-1 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	rm -rf parallel_test.hdf5
	export SUB=2
	srun   ./$TEST -size=128M -count=1 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	rm -rf parallel_test.hdf5
	export SUB=3
	srun   ./$TEST -size=128M -count=-1 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	rm -rf parallel_test.hdf5
	export SUB=4
	srun   ./$TEST -size=64M -count=4 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	rm -rf parallel_test.hdf5
	export SUB=5
	srun   ./$TEST -size=128M -count=4 -mb=256 SUB=$SUB  SLURM_JOBID=$SLURM_JOBID
	if [ $TEST == "h5b" ] ; then
	  conda deactivate
	fi
	module purge
	export LD_LIBRARY_PATH=$LIB_SAVE
	mkdir -p $SLURM_JOBID/$TEST
	mv times*$SLURM_JOBID* $SLURM_JOBID/$TEST
done
~/bin/dorun.py  $SLURM_JOB_ID
cp slurm-$SLURM_JOBID.out $SLURM_JOBID
