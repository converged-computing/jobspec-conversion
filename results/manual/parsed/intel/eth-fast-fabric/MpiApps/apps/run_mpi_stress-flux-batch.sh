#!/bin/bash
#FLUX: --job-name=faux-blackbean-0558
#FLUX: --urgency=16

MPICH_PREFIX=${MPICH_PREFIX:-`cat .prefix 2>/dev/null`}
trap "exit 1" SIGHUP SIGTERM SIGINT
CMD="mpi_stress/mpi_stress"
APP=mpi_stress
usage()
{
	echo "Usage: $0 number_of_processes [options]" >&2
	echo "          or"
	echo "       $0 --help"
	echo "    number_of_processes may be 'all' in which case PROCS_PER_NODE ranks will" >&2
	echo "                     be started for every entry in the MPI_HOSTS file" >&2
	echo "    [options] are passed to ${APP}: "
	echo  >&2
	echo "To get more details about [options] available: $0 1 --help" >&2
	exit 2
}
if [ -z "$1" -o x"$1" = x"-h" -o x"$1" = x"--help" ]
then
	usage
fi
if [ "$1" != "all" ] && ! [ "$1" -gt 0 ] 2>/dev/null
then
	usage
fi
NUM_PROCESSES=$1
MIN_PROCESSES=1
shift
if [ x"$1" = x"-h" -o x"$1" = x"--help" -o x"$1" = x"-help" ]
then
	set -- "-h"
fi
LOGFILE=
. ./prepare_run
(
	echo " Running Mpi Stress ..."
	show_mpi_hosts
	show_mpi_env
	set -x
	$MPI_RUN_CMD $CMD "$@"
	set +x
) 2>&1 | tee -i -a $LOGFILE
echo "########################################### " >> $LOGFILE
