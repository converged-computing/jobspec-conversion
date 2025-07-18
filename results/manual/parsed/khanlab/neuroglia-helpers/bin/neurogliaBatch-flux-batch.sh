#!/bin/bash
#FLUX: --job-name=arid-avocado-0309
#FLUX: --urgency=16

execpath=`dirname $0`
execpath=`realpath $execpath`
source ${NEUROGLIA_BASH_LIB}
if [ ! "$?" = 0 ]
then
	echo "Error initializing neuroglia-helpers, quitting $0"
	exit 1
fi
if [ ! -n "$SINGULARITY_OPTS" ]
then
	echo "SINGULARITY_OPTS not defined! exiting..." >&2
	exit 1
fi
cmd=$0
cmdname=${cmd##*/}
function usage {
   echo""
   echo "=========================================================================="
   echo "Interface for running pipeline scripts on the cluster with singularity"
   echo ""
   echo "  Loops through an input subject_list_txt (txt with subj id on each line)"
   echo "  Can be used to run scripts that generally take command-line parameters as:"
   echo ""
   echo "  <script_name> <before args (optional)> <subjid (required)> <after args (optional)>"
   echo ""
   echo "--------------------------------------------------------------------------"
   echo "Usage: $cmdname  <script_name>  <subject_list_txt>  <optional flags> "
   echo "--------------------------------------------------------------------------"
   echo ""
   echo "optional flags:"
   echo ""
   echo " -g : group/reduce job, pass the subject list instead of looping over subjects"
   echo " -s <subjid> : single-subject mode, run on a single subject (must be in subjlist) instead"
   echo " -t : test-mode, don/'t actually submit any jobs"
   echo " -A <account> : account to use for allocation (default: $CC_COMPUTE_ALLOC)"
   echo " -N <name> : name the batch job (default: name is command with path stripped off)"
   echo " -U <uri> : uri for singularity container to use (default: $NEUROGLIA_URI)"
   echo " -I <simg> : path to container to use (default: `shub-cache $NEUROGLIA_URI`)"
   echo ""
   usage_batch_before_after
   usage_job_templates
   usage_job_depends
}
while getopts "J" options; do
 case $options in
    J ) print_job_templates
	exit 1;;
    * ) usage
	exit 1;;
 esac
done
shift $((OPTIND-1))
if [ "$#" -lt 2 ]
then 
	usage
	exit 1
fi
output_dir=`realpath $PWD`
pipeline_script=$1
subjlist=$2
shift 2
before_args=""
after_args=""
job_template=Regular
depends=""
group=0
singlesubj=""
testmode=0
uri=$NEUROGLIA_URI
SINGULARITY_IMG=
cc_account=$CC_COMPUTE_ALLOC
scriptname=${pipeline_script##*/} #strip leading path
echo $scriptname >&2
while getopts "Jb:a:j:d:gs:tI:A:N:U:" options; do
 case $options in
    J ) print_job_templates
	exit 1;;
    b ) echo "	Setting arguments before subjid:  $OPTARG" >&2
	before_args=$OPTARG;;
    a ) echo "	Setting arguments after subjid:  $OPTARG" >&2
	after_args=$OPTARG;;
    j ) echo "	Using job template: $OPTARG" >&2
	job_template=$OPTARG;;
    d ) echo "	Using dependencies: $OPTARG" >&2
	depends=$OPTARG;;
    s ) echo "	Using single subject: $OPTARG" >&2
	singlesubj=$OPTARG;;
    g ) echo "	Using group/reduce mode (pass subject list instead of each subj" >&2
	group=1;;
    t ) echo "	Using test-mode (no submit jobs)" >&2
	testmode=1;;
    N ) echo "	Using job name: $OPTARG" >&2
	scriptname=$OPTARG;;
    I ) echo "	Using SINGULARITY_IMG: $OPTARG" >&2
	SINGULARITY_IMG=$OPTARG;;
    U ) echo "  Using singlarity image uri: $OPTARG" >&2
	uri=$OPTARG;;
    A ) echo "	Using allocation account: $OPTARG" >&2
	    cc_account=$OPTARG;;
    * ) usage
	exit 1;;
 esac
done
if [ ! -n "$SINGULARITY_IMG" ]
then
  SINGULARITY_IMG=`shub-cache $uri`
  if [ ! "$?" = 0 ]
  then
    echo "error loading $uri, exiting!"
    exit 
  fi
fi
if [ -f $subjlist ]
then
	N=`grep "[0-9a-zA-Z]"  $subjlist | wc -l`
else
	if [ "$group" = 0 ]
	then
 	echo "subjlist: $subjlist not a file!" >&2
	exit 1
	fi
fi
if [ ! -n "$singlesubj" ]
then
	indices="1-$N"  # all lines in subjlist, 1 to N
else
	N_matched=`grep -n $singlesubj $subjlist | wc -l` 
	if [ "$N_matched" == 1 ]
	then
		ind_subj=`grep -n $singlesubj $subjlist`
		indices=${ind_subj%%:*}
	fi
	if [ "$N_matched" == 0 ]
	then
		echo "single_subj: $singlesubj does not match any subjids in $subjlist!" >&2
		exit 1
	fi
	if [ "$N_matched" -gt 1 ]
	then
		echo "single_subj: $singlesubj matches multiple subjids in $subjlist!" >&2
		exit 1
	fi
fi
job_dir=$output_dir/jobs
mkdir -p $job_dir
job=$job_dir/$scriptname.$RANDOM.job
cp ${NEUROGLIA_DIR}/job-templates/${job_template}.job $job  
echo "#SBATCH --job-name=$scriptname" >> $job
echo "#SBATCH --account=$cc_account" >> $job
if [ "$group" == 0 ]
then
	#submit with array, using subj and subjlist, indexed by line number (1-N)
	echo "#SBATCH --output=$job_dir/${scriptname}.%A_%a.out" >> $job
	echo "#SBATCH --array=$indices" >> $job
	echo "export SCRATCH_DIR=/scratch/${USER}/\${SLURM_ARRAY_JOB_ID}_\${SLURM_ARRAY_TASK_ID}" >> $job
	echo "mkdir -p \$SCRATCH_DIR" >> $job
	echo "subj=\`head -n \$SLURM_ARRAY_TASK_ID `realpath $subjlist`  | tail -n 1\`" >> $job
	echo cd `pwd` >> $job
	echo "echo SINGULARITY_IMG: $SINGULARITY_IMG" >> $job
	echo "echo CMD: $pipeline_script $before_args \$subj $after_args" >>$job
	echo "echo START_TIME: \`date\`" >>$job
	echo singularity exec $SINGULARITY_OPTS $SINGULARITY_IMG $pipeline_script $before_args \$subj $after_args  >> $job
	echo "RETURNVAL=\$?" >> $job
	echo "rm -rf \$SCRATCH_DIR" >> $job
	echo "echo RETURNVAL=\$RETURNVAL" >>$job
	echo "echo END_TIME: \`date\`" >>$job
	echo "exit \$RETURNVAL" >> $job
	echo -n "		Queuing participant-level job, $depends ... " >&2
else
	#submit without arrays, using subjlist
	echo "#SBATCH --output=$job_dir/${scriptname}.%A.out" >> $job
	echo "export SCRATCH_DIR=/scratch/${USER}/\${SLURM_JOB_ID}" >> $job
	echo "mkdir -p \$SCRATCH_DIR" >> $job
	echo "echo SINGULARITY_IMG: $SINGULARITY_IMG" >> $job
	echo "echo CMD: $pipeline_script $before_args `realpath $subjlist` $after_args" >>$job
	echo "echo START_TIME: \`date\`" >>$job
	echo cd `pwd` >> $job
	echo singularity exec $SINGULARITY_OPTS $SINGULARITY_IMG $pipeline_script $before_args `realpath $subjlist` $after_args >> $job
	echo "RETURNVAL=\$?" >> $job
	echo "rm -rf \$SCRATCH_DIR" >> $job
	echo "echo RETURNVAL=\$RETURNVAL" >>$job
	echo "echo END_TIME: \`date\`" >>$job
	echo "exit \$RETURNVAL" >> $job
	echo -n "		Queuing group-level job, $depends ... " >&2
fi
if [ "$testmode" == 0 ]
then
message=`sbatch --dependency=$depends $job`
if ! echo ${message} | grep -q "[1-9][0-9]*$"; then 
	echo "Job(s) submission failed." >&2
	echo ${message} >&2
	exit 1
else
	jobid=$(echo ${message} | grep -oh "[1-9][0-9]*$")
fi
echo "jobid=$jobid" >&2
exec_job=$job_dir/$scriptname.$jobid.job
mv  $job $exec_job
else
	jobid=$RANDOM
	echo "fake-jobid=$jobid  (test-mode: no jobs submitted)" >&2
fi
echo $jobid
exit 0
