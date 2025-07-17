#!/bin/bash
#FLUX: --job-name=red-soup-8364
#FLUX: --urgency=16

MPICH_PREFIX=${MPICH_PREFIX:-`cat .prefix 2>/dev/null`}
trap "exit 1" SIGHUP SIGTERM SIGINT
BASE_DIR="osu-micro-benchmarks-5.9/mpi/"
if [ -z "$1" -o x"$1" == x"-h" -o x"$1" == x"--help" ]
then 
	echo "Usage: $0 <number_of_processes> <command> [options]"
	echo "          or"
	echo "       $0 --help"
	echo "    number_of_processes may be 'all' in which case PROCS_PER_NODE ranks will"
	echo "                     be started for every entry in the MPI_HOSTS file."
	echo "    <command> osu benchmark to run"
	echo "    [options] are passed to <command>"
	echo
	echo "For example: $0 2 osu_allgatherv -f"
	echo
	echo "Possible commands are: "
	sep=""
	n=0
	for f in $(find ${BASE_DIR} -executable -type f); do
		echo -n $sep$(basename $f)
		sep=", "
		n=$(($n + 1))
		if [ $((n % 4)) -eq 0 ]
		then
			echo "$sep"
			sep=""
		fi
	done
	echo
	echo
	echo "To get more details about [options] available: $0 1 <command> --help"
	echo "For example: $0 1 osu_fop_latency --help"
	exit 1
fi
NUM_PROCESSES=$1
shift
if [ $# -lt 1 ]; then
	echo "You must specify an OSU benchmark."
	exit 1
fi
CMD=`find ${BASE_DIR} -name "$1"`
if [ -z ${CMD} ]; then
	echo "$1 is not a valid OSU benchmark."
	exit 1
fi
APP="$1"
shift
if [ x"$1" = x"-h" -o x"$1" = x"--help" -o x"$1" = x"-help" ]
then
	set -- "-h"
	MIN_PROCESSES=1
fi
LOGFILE=
. ./prepare_run
(
	echo " Running $CMD ..."
	show_mpi_hosts
	show_mpi_env
	set -x
	$MPI_RUN_CMD $CMD "$@"
	set +x
) 2>&1 | tee -i -a $LOGFILE
echo "########################################### " >> $LOGFILE
