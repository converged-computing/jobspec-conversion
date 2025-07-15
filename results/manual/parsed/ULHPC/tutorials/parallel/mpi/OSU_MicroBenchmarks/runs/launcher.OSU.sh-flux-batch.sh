#!/bin/bash
#FLUX: --job-name=bricky-malarkey-2721
#FLUX: --queue=batch
#FLUX: -t=300
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'

mkdir -p logs
VERSION=1.1
COMMAND=$(basename $0)
COMMAND_LINE="${COMMAND} $@"
NOOP=
BENCH=OSU
declare -a APPs=(osu_get_latency osu_get_bw)
TYPE='one-sided'
MCA="--mca btl openib,self,sm"
DELAY=1
print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
usage(){
    cat <<EOF
NAME
  $COMMAND -- Slurm launcher for OSU Micro-Benchmarks
SYNOPSIS
  $COMMAND -h
  $COMMAND [intel] [...]
DESCRIPTION
  $COMMAND runs the OSU micro-benchmark latency and bandwidth test
  for a given MPI suit (OpenMPI by default)
OPTIONS
  --bin <EXE>
     Comma separated list of OSU [MPI] benchmark compiled binary
     Default: osu_get_latency osu_get_bw
  -d --dir <DIR>
     Set the data directory -- output results will be placed here
     Default: ${DATADIR}*
  -m --mpi <SUITE>
     Using SUITE MPI
     Default: ${SUITE}
  --noop --dry-tun
     DO NOT perform the benchmark
  -p --params '<OPTS>'
     Parameters for the IOR run
     Default: '${OPTS}'
AUTHOR
  Sebastien Varrette <Sebastien.Varrette@uni.lu>
COPYRIGHT
  This is free software; see the source for copying conditions.  There is
  NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
}
SCRIPTFILENAME=$(basename $0)
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPTDIR}" == *"slurmd"* ]] && RUNDIR=${SLURM_SUBMIT_DIR} || RUNDIR=${SCRIPTDIR}
else
    RUNDIR=${SCRIPTDIR}
fi
TOP_SRCDIR=$HOME/tutorials/OSU-MicroBenchmarks
BUILDDIR="${TOP_SRCDIR}/build"
SUITE=openmpi
MPI_NUM_PROCESS=${SLURM_NTASKS:-1}
run_osu() {
    local logfile=$1
    local app=$2
    [ -z "${logfile}" ] && print_error_and_exit "logfile parameter not passed"
    echo "# ================================================================="
    echo "# => ${BENCH} Micro-benchmark (${SUITE})"
    echo "#    $app"
    echo "# ================================================================="
    if [ -n "${NOOP}" ]; then
        echo '/!\ WARNING: noop / dry-run execution'
        echo "             the command '${CMD}' won't be executed"
        exit 0
    fi
    # [eventually] create the data directory
    if [ ! -d "${DATADIR}" ]; then
        echo "=> creating ${DATADIR}"
        mkdir -p ${DATADIR}
    fi
    ### General SLURM Parameters
    start_time=$(date +%s)
    tee -a ${logfile} <<EOF
EOF
    # Run the OSU bench
    cd ${DATADIR}
    echo "   command performed in $(pwd)"
    ${CMD} $app |& tee -a ${logfile}
    cd -
    end_time=$(date +%s)
    elapsed=$(echo "${end_time}-${start_time}" | bc)
    tee -a ${logfile} <<EOF
EOF
}
if [ -f  /etc/profile ]; then
    .  /etc/profile
fi
while [ $# -ge 1 ]; do
    case $1 in
        -h | --help)  usage;   exit 0;;
        -b | --bin | --app* | --exe)
            shift;
            IFS=',' read -a APPs <<< "$1";;
        -c | --collective) TYPE=collective;;
        -d | --dir | --datadir)   shift; DATADIR=$1;;
        --eth*) MCA="--mca btl tcp,self";;
        -m | --mpi)   shift; SUITE=$1;;
        -n | --noop | --dry-run) NOOP=$1;;
        -o | --one-sided)    TYPE=one-sided;;
        -t | --type)  shift; TYPE=$1;;
        intel*   | --intel*)   SUITE='intel';;
        *) SUITE='openmpi';;
    esac
    shift
done
if [ -n "${SUITE}" ]; then
    BUILDDIR="${BUILDDIR}.${SUITE}"
    DATADIR="${RUNDIR}/${SUITE}"
fi
APPDIR="${BUILDDIR}/mpi/${TYPE}"
[ ! -d "${APPDIR}" ] && print_error_and_exit "Build dir '${APPDIR}' does not exist"
case ${SUITE} in
    openmpi)  MODULE=mpi/OpenMPI;;
    mvapich*) MODULE=mpi/MVAPICH2;;
    intel)    MODULE=toolchain/intel;
              #              export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so;;
              ;;
    *)  print_error_and_exit "Unsupported MPI suite"
esac
module purge || print_error_and_exit "Unable to find the 'module' command -- Not on a node?"
module load ${MODULE}
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
echo "APPDIR = ${APPDIR}"
echo "APPs   = ${APPs[@]}"
CMD="srun -n ${MPI_NUM_PROCESS}"
for bench in "${APPs[@]}"; do
    logfile="${DATADIR}/${bench}_$(date +%Hh%Mm%S).log"
    app="${APPDIR}/${bench}"
    [ ! -x "$app" ] && print_error_and_exit "Unable to find the benchmark app '${app}'"
    run_osu $logfile $app
    echo "=> now sleeping for ${DELAY}s"
    sleep $DELAY
done
