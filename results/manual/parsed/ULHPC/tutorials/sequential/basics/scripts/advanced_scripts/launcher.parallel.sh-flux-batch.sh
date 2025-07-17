#!/bin/bash
#FLUX: --job-name=GnuParallel
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

mkdir -p logs
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPT_DIR}" == *"slurmd"* ]] && TOP_DIR=${SLURM_SUBMIT_DIR} || TOP_DIR=$(realpath -es "${SCRIPT_DIR}")
else
    TOP_DIR="${SCRIPT_DIR}"
fi
CMD_PREFIX=
ECHO=
DEBUG=
SRUN="srun  --exclusive -n1 -c ${SLURM_CPUS_PER_TASK:=1} --cpu-bind=cores"
PARALLEL="parallel"
JOBLOGFILE=logs/state.parallel.log
TASK=${TASK:=${HOME}/bin/app.exe}
TASKLIST="{1..8}"
TASKLISTFILE=
print_error_and_exit() { echo "*** ERROR *** $*"; exit 1; }
usage() {
    less <<EOF
NAME
    $(basename $0): Generic launcher using GNU parallel
    within a single node to run embarrasingly parallel problems, i.e. execute
    multiple times the command '\${TASK}' within a 'tunnel' set to run NO MORE
    THAN \${SLURM_NTASKS} tasks in parallel.
    State of the execution is stored in logs/state.parallel.log and is used to
    resume the execution later on, from where it stoppped (either due to the
    fact that the slurm job has been stopped by failure or by hitting a walltime
    limit) next time you invoke this script.
    In particular, if you need to rerun this GNU Parallel job, be sure to delete
    the logfile logs/state*.parallel.log or it will think it has already
    finished!
    By default, '${TASK}' command is executed with arguments ${TASKLIST}
    Using '-a <input_file>', <input_file> is used as input source
USAGE
   [sbatch] $0 [-n] [TASKLIST]
   TASK=/path/to/app.exe [sbatch] $0 [-n] [TASKLIST]
   [sbatch] $0 [-n] -a TASKLISTFILE
   TASK=/path/to/app.exe [sbatch] $0 [-n] -a TASKLISTFILE
OPTIONS
  -a --arg-file FILE  Use FILE as input source
  -d --debug          Print debugging information
  --joblog FILE       Logfile for executed jobs (Default: ${JOBLOGFILE})
  -n --dry-run        Dry run mode (echo **full** parallel command)
  -t --test --noop    No-operation mode: echo the run commands
EXAMPLES
  Within an interactive job (use --exclusive for some reason in that case)
      (access)$> si --ntasks-per-node 28
      (node)$> $0 -n    # dry-run - print full parallel command
      (node)$> $0 -t    # noop mode - print commands
      (node)$> $0
  Within a passive job
      (access)$> sbatch $0
  Within a passive job, using several cores (2) per tasks
      (access)$> sbatch --ntasks-per-socket 7 --ntasks-per-node 14 -c 2 $0
  Use another range of parameters - don't forget the souble quotes
      (access)$> sbatch $0 "{1..100}"
  Use an input file
      (access)$> sbatch $0 -a path/to/tasklistfile
  Get the most interesting usage statistics of your jobs <JOBID> (in particular
  for each job step) with:
     slist <JOBID> [-X]
AUTHOR
  S. Varrette and UL HPC Team <hpc-team@uni.lu>
COPYRIGHT
	This is free software; see the source for copying conditions. There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
}
print_debug_info(){
cat <<EOF
 TOP_DIR      = ${TOP_DIR}
 PARALLEL     = ${PARALLEL}
 TASK         = ${TASK}
 TASKLIST     = $(eval echo ${TASKLIST})
 TASKLISTFILE = ${TASKLISTFILE}
EOF
[ -n "${SLURM_JOBID}" ] && echo "$(scontrol show job ${SLURM_JOBID})"
}
while [ $# -ge 1 ]; do
    case $1 in
        -h | --help) usage; exit 0;;
        -d | --debug)    DEBUG=$1;;
        -a | --arg-file) shift;
            TASKLISTFILE=$1;
            PARALLEL="${PARALLEL} -a $1";;
        --joblog) shift; JOBLOGFILE=$1;;
        -n | --dry-run)  CMD_PREFIX=echo;;
        -t | --test | --noop) ECHO=echo;;
        *) TASKLIST=$*;;
    esac
    shift;
done
PARALLEL="${PARALLEL} --delay .2 -j ${SLURM_NTASKS} --joblog ${JOBLOGFILE} --resume"
[ -n "${DEBUG}"  ] && print_debug_info
[ ! -x "${TASK}" ] && print_error_and_exit "Unable to find TASK=${TASK}"
module purge || print_error_and_exit "Unable to find the 'module' command"
start=$(date +%s)
echo "### Starting timestamp (s): ${start}"
if [ -z "${TASKLISTFILE}" ]; then
    # parallel uses ::: to separate options. Here default {1..8} is a shell expansion
    # so parallel will run the command passing the numbers 1 through 8 via argument {1}
    ${CMD_PREFIX} ${PARALLEL} "${ECHO} ${SRUN} ${TASK} {1}" ::: $(eval echo ${TASKLIST})
else
    # use ${TASKLISTFILE} as input source for TASKLIST
    ${CMD_PREFIX} ${PARALLEL} -a ${TASKLISTFILE} "${ECHO} ${SRUN} ${TASK} {}"
fi
end=$(date +%s)
cat <<EOF
Beware that the GNU parallel option --resume makes it read the log file set by
--joblog (i.e. logs/state*.log) to figure out the last unfinished task (due to the
fact that the slurm job has been stopped due to failure or by hitting a walltime
limit) and continue from there.
In particular, if you need to rerun this GNU Parallel job, be sure to delete the
logfile logs/state*.parallel.log or it will think it has already finished!
EOF
if [ -n "${ECHO}" ]; then
    echo "/!\ WARNING: Test mode - removing joblog state file '${JOBLOGFILE}'"
    rm -f ${JOBLOGFILE}
fi
