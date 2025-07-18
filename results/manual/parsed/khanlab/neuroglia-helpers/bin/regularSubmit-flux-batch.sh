#!/bin/bash
#FLUX: --job-name=bricky-bike-1364
#FLUX: --urgency=16

execpath=`dirname $0`
execpath=`realpath $execpath`
source ${NEUROGLIA_BASH_LIB}
if [ ! "$?" = 0 ]
then
	echo "Error initializing neuroglia-helpers, quitting $0"
	exit 1
fi
function usage {
   echo""
   echo "=========================================================================="
   echo "Interface for submitting a single cluster job with singularity"
   echo ""
   echo "--------------------------------------------------------------------------"
   echo "Usage: $scriptname <optional flags>  <command to run>"
   echo "--------------------------------------------------------------------------"
   echo ""
   echo "optional flags:"
   echo ""
   echo " -t : test-mode, don/'t actually submit any jobs"
   echo " -n : ninja-mode, delete job file and hide command in log file (for passwords in getDicomTgz)"
   echo " -A <account> : account to use for allocation (default: $CC_COMPUTE_ALLOC)"
   echo " -E <env_script>:  script to source for env setup"
   echo ""
   echo ""
   usage_job_templates
   usage_job_depends
}
if [ "$#" -lt 1 ]
then 
  usage
  exit 1
fi
job_template=Regular
depends=""
testmode=0
enable_wait=0
ninja=0
cc_account=$CC_COMPUTE_ALLOC
scriptname=
output_dir=`realpath $PWD`
envscript=
gpu_req=
while getopts "Jj:d:tWnN:A:E:g:" options; do
 case $options in
    J ) print_job_templates
	exit 1;;
    j ) echo "	Using job template: $OPTARG" >&2
	job_template=$OPTARG;;
    d ) echo "	Using dependencies: $OPTARG" >&2
	depends=$OPTARG;;
    t ) echo "	Using test-mode (no submit jobs)" >&2
	testmode=1;;
    W ) echo "  Wait until job completes" >&2
	enable_wait=1;;
    n ) echo "  Using ninja mode" >&2
	ninja=1;;
    N ) echo "	Using job name: $OPTARG" >&2
	scriptname=$OPTARG;;
    A ) echo "	Using allocation account: $OPTARG" >&2
	    cc_account=$OPTARG;;
    E ) echo "	Sourcing $OPTARG in each job" >&2
	envscript=$OPTARG;;
	g) echo "enabling ${OPTARG} t4 gpus, with allocation $CC_GPU_ALLOC"
    gpu_req="gpu:t4:${OPTARG}"
    cc_account=$CC_GPU_ALLOC;;
    * ) usage
	exit 1;;
 esac
done
shift $((OPTIND-1))
run_cmd=$@
if [ ! -n "$scriptname" ]
then
scriptname=${run_cmd%%\ *} #remove all but first word
scriptname=${scriptname##*/} #remove up to leading slash
fi
echo $scriptname >&2
job_dir=$output_dir/jobs
mkdir -p $job_dir
job=$job_dir/$scriptname.$RANDOM.job
cp ${NEUROGLIA_DIR}/job-templates/${job_template}.job $job  
echo "#SBATCH --job-name=$scriptname" >> $job
echo "#SBATCH --account=$cc_account" >> $job
echo "#SBATCH --output=$job_dir/${scriptname}.%A.out" >> $job
if [ -n "$gpu_req" ]
then
    echo "#SBATCH --gres=${gpu_req}" >> $job
fi
if [ -n "$envscript" ]
then
	echo "source $envscript" >> $job
fi
if [ -n "$depends" ]
then
    dependsopt="--dependency=$depends"
fi
if [ "$ninja" = 1 ]
then
echo "echo Ninja-mode - delete job file" >> $job
else
echo "echo CMD: $@" >>$job
fi
echo "echo START_TIME: \`date\`" >>$job
echo cd `pwd` >> $job
echo $@ >> $job
echo "RETURNVAL=\$?" >> $job
echo "echo RETURNVAL=\$RETURNVAL" >>$job
echo "echo END_TIME: \`date\`" >>$job
echo "exit \$RETURNVAL" >> $job
echo -n "		Queuing job, $depends ... " >&2
if [ "$testmode" = 0 ]
then
if [ "$enable_wait" == 1 ]
then
message=`sbatch $dependsopt -W $job`
else
message=`sbatch $dependsopt $job`
fi
if ! echo ${message} | grep -q "[1-9][0-9]*$"; then 
	echo "Job(s) submission failed." >&2
	echo ${message} >&2
	exit 1
else
	jobid=$(echo ${message} | grep -oh "[1-9][0-9]*$")
fi
echo "jobid=$jobid" >&2
exec_job=$job_dir/$scriptname.$jobid.job
if [ "$ninja" = 0 ]
then
mv  $job $exec_job
fi
else
	jobid=$RANDOM
	echo "fake-jobid=$jobid  (test-mode: no jobs submitted)" >&2
fi
if [ "$ninja" = 1 ]
then
	#delete job
	rm -f $job
fi
echo $jobid
exit 0
