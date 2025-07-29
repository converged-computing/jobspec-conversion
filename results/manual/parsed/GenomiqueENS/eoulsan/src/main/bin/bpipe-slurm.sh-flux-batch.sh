#!/bin/bash
#FLUX: --job-name=$NAME
#FLUX: --queue=$QUEUE
#FLUX: --urgency=16

program_name=bpipe-slurm
SUCCESS=0
INCORRECT_FIRST_ARGUMENT=1 # must be start, stop, or status
MISSING_JOB_PARAMETER=2    # one of the env vars not defined
STOP_MISSING_JOBID=3       # stop command not given job id as parameter
STATUS_MISSING_JOBID=4     # status command not given job id as parameter
SCANCEL_FAILED=5              # scancel command returned non-zero exit status
SCONTROL_FAILED=6             # scontrol command returned non-zero exit status
SBATCH_FAILED=7              # sbatch command returned non-zero exit status
MKDIR_JOBDIR_FAILED=8
JOBTYPE_FAILED=9              # jobtype variable led to non-zero exit status
ESSENTIAL_ENV_VARS="COMMAND NAME"
OPTIONAL_ENV_VARS="WALLTIME PROCS QUEUE JOBDIR JOBTYPE MEMORY"
DEFAULT_BATCH_MEM=4096
DEFAULT_BATCH_PROCS=1
DEFAULT_WALLTIME="01:00:00" # one hour
DEFAULT_QUEUE=debug	#Queue is parition in slurm, will use this with -p
DEFAULT_JOBTYPE=single	#Should be single, smp or mpi
usage () {
echo "usage: $program_name (start | stop ID | status ID)"
echo "start needs these environment variables: $ESSENTIAL_ENV_VARS"
echo "start will use these variables if defined: $OPTIONAL_ENV_VARS"
}
make_slurm_script () {
for v in $ESSENTIAL_ENV_VARS; do
eval "k=\$$v"
if [[ -z $k ]]; then
echo "$program_name ERROR: environment variable $v not defined"
echo "these environment variables are required: $ESSENTIAL_ENV_VARS"
exit $MISSING_JOB_PARAMETER
fi
done
if [[ -z $WALLTIME ]]; then
WALLTIME=$DEFAULT_WALLTIME
fi
if [[ -z $QUEUE ]]; then
QUEUE=$DEFAULT_QUEUE
fi
if [[ -z $JOBTYPE ]]; then
JOBTYPE=$DEFAULT_JOBTYPE
fi
if [[ -n $JOBDIR ]]; then
if [[ ! -d "$JOBDIR" ]]; then
mkdir "$JOBDIR"
if [[ $? != 0 ]]; then
echo "$program_name ERROR: could not create job directory $JOBDIR"
exit $MKDIR_JOBDIR_FAILED
fi
fi
job_script_name="$JOBDIR/job.slurm"
else
job_script_name="job.slurm"
fi
if [[  ! -z $ACCOUNT ]]; then
account="#SBATCH --account $ACCOUNT"
fi
case $JOBTYPE in
single) if [[ -z $MEMORY ]]; then
memory_request="#SBATCH --mem=${DEFAULT_BATCH_MEM}"
else
memory_request="#SBATCH --mem=${MEMORY}"
fi
if [[ -z $PROCS ]]; then
procs_request="#SBATCH --ntasks=$DEFAULT_BATCH_PROCS"
else
procs_request=$(printf "#SBATCH --ntasks=$PROCS\n#SBATCH --nodes=1")
fi
command_prefix="";; # used in mpi only
smp)   if [[ -z $MEMORY ]]; then
memory_request=""
else
memory_request="#SBATCH --mem=${MEMORY}"
fi
command_prefix="" # used in mpi only
procs_request=$(printf "#SBATCH --nodes=1\n#SBATCH --exclusive");;
mpi) if [[ -z $MEMORY ]]; then
memory_request="#SBATCH --mem-per-cpu=${DEFAULT_BATCH_MEM}"
else
memory_request="#SBATCH --mem-per-cpu=${MEMORY}"
fi
if [[ -z $PROCS ]]; then
procs_request="#SBATCH --ntasks=$DEFAULT_BATCH_PROCS"
else
procs_request="#SBATCH --ntasks=$PROCS"
fi
command_prefix="mpirun";;
esac
mods_request = ""
if [[  ! -z $MODULES ]]; then
for MOD in $MODULES
do
mods_request="${mods_request}
module load $MOD"
done
fi
cat > $job_script_name << HERE
$account
$memory_request
$procs_request
set -o errexit
$mods_request
$command_prefix $COMMAND
HERE
echo $job_script_name
}
start () {
job_script_name=`make_slurm_script`
if [[ -f $job_script_name ]]
then
job_id_full=`sbatch $job_script_name`
sbatch_exit_status=$?
if [[ $? -eq 0 ]]
then
job_id_number=`echo $job_id_full | sed 's/[^0-9]//g'`
echo $job_id_number
else
echo "$program_name ERROR: sbatch returned non zero exit status $sbatch_exit_status"
exit $SBATCH_FAILED
fi
else
echo "$program_name ERROR: could not create job script $job_script_name"
fi
}
stop () {
if [[ $# -ge 1 ]]
then
scancel "$1"
scancel_success=$?
if [[ $scancel_success == 0 ]]
then
exit $SUCCESS
else
exit $SCANCEL_FAILED
fi
else
echo "$program_name ERROR: stop requires a job identifier"
exit $STOP_MISSING_JOBID
fi
}
status () {
if [[ $# -ge 1 ]]
then
scontrol_output=`scontrol show job $1`
scontrol_success=$?
if [[ $scontrol_success == 0 ]]
then
job_state=`echo $scontrol_output|grep JobState|sed 's/.*JobState=\([A-Z]*\) .*/\1/'` # JobState is in caps
case "$job_state" in
CONFIGURING|PENDING|SUSPENDED) echo WAITING;;
COMPLETING|RUNNING) echo RUNNING;;
CANCELLED) echo COMPLETE 999;; # Artificial exit code because Slurm does not provide one
COMPLETED|FAILED|NODE_FAIL|PREEMPTED|TIMEOUT)
command_exit_status=`echo $scontrol_output|tr ' ' '\n' |awk -vk="ExitCode" -F"=" '$1~k{ print $2}'|awk -F":" '{print $1}'`
echo "COMPLETE $command_exit_status";;
*) echo UNKNOWN;;
esac
exit $SUCCESS
elif [[ $scontrol_success == 1 ]]
then
errortext="slurm_load_jobs error: Invalid job id specified"
if  [[ $scontrol_output == $errortext ]]
then
echo UNKNOWN
else
exit $SCONTROL_FAILED
fi
else
exit $SCONTROL_FAILED
fi
else
echo "$program_name ERROR: status requires a job identifier"
exit $STATUS_MISSING_JOBID
fi
}
main () {
if [[ $# -ge 1 ]]
then
case "$1" in
start)  start;;
stop)   shift
stop "$@";;
status) shift
status "$@";;
*) usage
exit $INCORRECT_FIRST_ARGUMENT
;;
esac
else
usage
exit $INCORRECT_FIRST_ARGUMENT
fi
exit $SUCCESS
}
main "$@"
