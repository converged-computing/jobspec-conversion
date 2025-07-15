#!/bin/bash
#FLUX: --job-name=fat-gato-5162
#FLUX: --urgency=16

MPICH_PREFIX=${MPICH_PREFIX:-`cat .prefix 2>/dev/null`}
trap "exit 1" SIGHUP SIGTERM SIGINT
if [ -z "$1" -o x"$1" == x"-h" -o x"$1" == x"--help" ]
then 
	echo "Usage: $0 number_of_processes [full]."
	echo "             or"
	echo "       $0 --help"
	echo "    number_of_processes may be 'all' in which case PROCS_PER_NODE ranks will"
	echo "                     be started for every entry in the MPI_HOSTS file"
	if [ -d NPB3.2.1/NPB3.2-MPI/bin ]
	then
	echo "    full - include NASA and HPL benchmarks"
	else
	echo "    full - include HPL benchmark"
	fi
	echo "For example: $0 2"
	exit 1
fi
full=n
if [ x"$2" = x"full" ]
then
	full=y
fi
NUM_PROCESSES=$1
PARAM_FILE=""
APP=multi
. ./prepare_run
LATENCY_CMD="latency/latency 100000 0"
LATENCY_CMD2="latency/latency 100000 4"
BANDWIDTH_CMD="bandwidth/bw 100 100000"
IMB_CMD="imb/IMB-MPI1"
HPL_CMD="./xhpl"
HPL_DIR="$PWD/hpl-2.3/bin/ICS.`uname -s`.`./get_mpi_blas.sh`"
{
if [ $USING_MPD = y ]
then
    MPI_RUN_CMD_HPL="$MPI_RUN_CMD -wdir $HPL_DIR"
else
    MPI_RUN_CMD_HPL="$MPI_RUN_CMD"
fi
show_mpi_hosts
show_mpi_env
if [ $NUM_PROCESSES -eq 2 ]
then
	echo " Running Latency ..."
	date
	set -x
	$MPI_RUN_CMD $LATENCY_CMD
	set +x
	date
	set -x
	$MPI_RUN_CMD $LATENCY_CMD2
	set +x
	date
	echo "########################################### "
	echo " Running Bandwidth ..."
	date
	set -x
	$MPI_RUN_CMD $BANDWIDTH_CMD
	set +x
	date
fi
echo "########################################### "
echo " Running IMB Benchmarks ..."
date
set -x
$MPI_RUN_CMD $IMB_CMD
set +x
date
echo "########################################### "
if [ "$full" = y -a -d NPB3.2.1/NPB3.2-MPI/bin ]
then
	echo " Running NASA Parallel Benchmarks ..."
	class="B"
	for test in cg ep lu is mg
	do
		echo "    Running $test.$class.$NUM_PROCESSES benchmark ..."
		date
		set -x
		$MPI_RUN_CMD NPB3.2.1/NPB3.2-MPI/bin/$test.$class.$NUM_PROCESSES
		set +x
		date
	done
	echo "########################################### "
fi
if [ "$full" = y ]
then
	echo " Running High Performance Computing Linpack Benchmark (HPL) ..."
	date
	set -x
	# need to cd so HPL.dat in current directory
	(cd $HPL_DIR; $MPI_RUN_CMD_HPL $HPL_CMD )
	set +x
	date
	echo "########################################### "
fi
} 2>&1 | tee -a -i $LOGFILE
