#!/bin/bash
#FLUX: --job-name=placid-noodle-4239
#FLUX: --urgency=16

ERROR () {
    echo "[OHPC-TEST:ERROR]: $1" >&2
    exit 1
}
ERROR_RETURN () {
    echo "[OHPC-TEST:ERROR]: $1" >&2
    return 1
}
check_if_rpm_installed () {
    $(rpm -q --quiet $1) || ERROR "RPM $1 is not installed locally"
}
check_rms(){
    if [ -s /etc/pbs.conf ]; then
	export RESOURCE_MANAGER=openpbs
    elif [ -s /etc/slurm/slurm.conf ]; then
	export RESOURCE_MANAGER=slurm
    else
	ERROR "Unsupported or unknown resource manager"
	exit 1
    fi
}
check_exe() {
    type "$1" >& /dev/null
    if [ $? -ne 0 ];then
	ERROR_RETURN "$1 is not available for execution"
    fi
}
get_python_vars() {
    local __python_family=$1
    if [ "x$__python_family" == "xpython3" ]; then
        export _python=python3
        export python_module_prefix=py3
        if [ "x$DISTRO_FAMILY" == "xCentOS" -o "x$DISTRO_FAMILY" == "xRHEL" ];then
            export python_package_prefix=python3
        else
            export python_package_prefix=python3
        fi
    fi
}
save_logs_compiler_family()
{
    if [ $# -lt 2 ];then
	ERROR "insufficient input provided to save_logs_compiler_family()"
    fi
    local __testDir=$1
    local __compiler=$2
    local __saveDir="family-$__compiler"
    cd $__testDir || ERROR "unable to cd to $_testDir"
    if [ -d "$__saveDir" ];then
	rm -rf "$__saveDir"
    fi
    mkdir "$__saveDir"
    shopt -s nullglob
    # Cache .log files
    for i in *.log; do 
	mv $i "$__saveDir" || ERROR "Unable to move file -> $i";
    done
    # Also cache log.xml files (for JUnit parsing)
    for i in *.log.xml; do 
	mv $i "$__saveDir" || ERROR "Unable to move file -> $i";
    done
    cd - > /dev/null
} # end of save_logs_compiler_family()
save_logs_mpi_family()
{
    if [ $# -lt 3 ];then
	ERROR "insufficient input provided to save_logs_mpi_family()"
    fi
    local __testDir=$1
    local __compiler=$2
    local __mpi=$3
    local __saveDir="family-$__compiler-$__mpi"
    cd $__testDir || ERROR "unable to cd to $_testDir"
    if [ -d "$__saveDir" ];then
	rm -rf "$__saveDir"
    fi
    mkdir "$__saveDir"
    shopt -s nullglob
    # Cache .log files
    for i in *.log; do 
	mv $i "$__saveDir" || ERROR "Unable to move file -> $i";
    done
    # Also cache log.xml files (for JUnit parsing)
    for i in *.log.xml; do 
	mv $i "$__saveDir" || ERROR "Unable to move file -> $i";
	done
    cd - > /dev/null
} # end of save_logs_mpi_family()
check_compiler_family()
{
    local __CC=$1
    local __CXX=$2
    local __FC=$3
    local myCC=""
    local myCXX=""
    local myFC=""
    if [ $LMOD_FAMILY_COMPILER == "intel" ];then
	myCC=icx
	myCXX=icpx
	myFC=ifx
  elif [[ $LMOD_FAMILY_COMPILER =~ "arm" ]];then
        myCC=armclang
        myCXX=armclang++
        myFC=armflang
  elif [[ $LMOD_FAMILY_COMPILER =~ "acfl" ]];then
        myCC=armclang
        myCXX=armclang++
        myFC=armflang
    elif [ $LMOD_FAMILY_COMPILER == "gnu" ];then
	myCC=gcc
	myCXX=g++
	myFC=gfortran
    elif [ $LMOD_FAMILY_COMPILER == "gnu12" ];then
	myCC=gcc
	myCXX=g++
	myFC=gfortran
    elif [ $LMOD_FAMILY_COMPILER == "gnu9" ];then
	myCC=gcc
	myCXX=g++
	myFC=gfortran
    elif [[ $LMOD_FAMILY_COMPILER == "llvm9" ]];then
	myCC=clang
	myCXX=clang++
	myFC=gfortran
    else
	ERROR "Unknown compiler family"
	exit 1
    fi
    eval $__CC="'$myCC'"
    eval $__CXX="'$myCXX'"
    eval $__FC="'$myFC'"
}
run_serial_binary () {
    # Parse optional arguments
    output_file=""
    timeout=1		# default job timeout (in minutes)
    local OPTIND=1
    while getopts "o:t:" opt; do
	case "$opt" in
	    o)	output_file="$OPTARG"
		;;
	    t)	timeout="$OPTARG"
		;;
	    '?')
		echo "Unknown option given to run_serial_binary" >&2
		exit 1
		;;
	esac
    done
    shift "$((OPTIND-1))" # Shift off the options and optional --.
    EXE=$1
    shift
    check_exe $EXE
    if [ -z "$RESOURCE_MANAGER" ];then
	ERROR_RETURN "OHPC resource manager is not defined - please set via RESOURCE_MANAGER variable"
    fi
    if [ "$RESOURCE_MANAGER" = "slurm" ];then
	if [ -n "$output_file" ];then
	    srun -n 1 -N 1 -t $timeout $EXE "$@" >& $output_file
	else
	    # srun -n 1 -N 1 -t $timeout $EXE "$@"
	    eval srun -n 1 -N 1 -t $timeout $EXE "$@"
	fi
	return $?
   elif [ "$RESOURCE_MANAGER" = "openpbs" ];then
	# pbs presently won't search PATH and doesn't run out of cwd;cull out full path to $EXE
	echo "EXE = $EXE"
	local myPath=`command -v $EXE`
	myPath=`readlink -f $myPath`
	# Generate script with commands so we can execute out of submission directory
	jobScript=".job.$RANDOM"
	echo "#!/bin/bash" > $jobScript
	echo "cd \${PBS_O_WORKDIR}" >> $jobScript
	echo $EXE "$@" >> $jobScript
	chmod 700 $jobScript
        if [ -n "$output_file" ];then
            qsub -k oe -W block=true -l select=1 -l walltime=$timeout -- `readlink -f $jobScript` > .job_in
	    JOB=`cat .job_in | awk -F . '{print $1}'`
	    [[ -e ${HOME}/STDIN.o${JOB} ]] || exit 1
	    mv ${HOME}/STDIN.o${JOB} $output_file
	    cat $output_file
        else
            qsub -k n -W block=true -l select=1 -l walltime=$timeout -- `readlink -f $jobScript`
	    local statusCode=$?
	    rm -f $jobScript
	    return $statusCode
        fi
    else
	ERROR_RETURN "Unsupported resource manager"
    fi
}
run_mpi_binary () {
    # Parse optional arguments
    input_file=""
    output_file=""
    if [ "$RESOURCE_MANAGER" = "slurm" ]; then
		if [ ! -z "$SIMPLE_CI" ]; then
			timeout=5		# default job timeout (in minutes)
			# Do not use pmix in the SIMPLE_CI case (GitHub Actions)
			unset OHPC_MPI_LAUNCHERS
		else
			timeout=2		# default job timeout (in minutes)
		fi
    else
		timeout="00:02:00"
    fi
    local OPTIND=1
    while getopts "i:o:s:t:" opt; do
    case "$opt" in
	i)  input_file="$OPTARG"
	    ;;
	o)  output_file="$OPTARG"
	    ;;
	s)  scalasca="$OPTARG"
	    ;;
	t)  timeout="$OPTARG"
	    ;;
	'?')
	    echo "Unknown option given to run_mpi_binary" >&2
	    exit 1
	    ;;
	esac
    done
    if [ -z "$scalasca" ];then
    mpi_launcher="prun"
    else
    mpi_launcher="scalasca -analyze prun"
    fi
    shift "$((OPTIND-1))" # Shift off the options and optional --.
    EXE=$1
    ARGS=$2
    NNODES=$3
    NTASKS=$4
    check_exe $EXE
    if [ -z "$RESOURCE_MANAGER" ];then
	ERROR_RETURN "Resource manager is not defined - please set via RESOURCE_MANAGER variable"
    fi
    if [ -z "$LMOD_FAMILY_MPI" ];then
	ERROR_RETURN "MPI toolchain s not loaded - please load MPI stack first"
    fi
    if [ "$RESOURCE_MANAGER" = "slurm" ];then
	if [ "$LMOD_FAMILY_MPI" = "impi" -o "$LMOD_FAMILY_MPI" = "mvapich2" -o "$LMOD_FAMILY_MPI" = "openmpi4" -o "$LMOD_FAMILY_MPI" = "mpich" ];then
	    jobScript=/tmp/job.$USER.$RANDOM
	    echo "#!/bin/bash"		    > $jobScript
	    echo "#SBATCH -J OpenHPC-test" >> $jobScript
	    echo "#SBATCH -N $NNODES"      >> $jobScript
	    echo "#SBATCH -n $NTASKS"      >> $jobScript
	    echo "#SBATCH -t $timeout"     >> $jobScript
	    echo "#SBATCH -o job.%j.out"   >> $jobScript
	    if [ -n "$input_file" ];then
		echo "$mpi_launcher $EXE $ARGS < $input_file" >> $jobScript
	    else
		echo "$mpi_launcher $EXE $ARGS"		      >> $jobScript
	    fi
	    # Submit batch job
	    tmpState=/tmp/submitId.$RANDOM
	    sbatch $jobScript >& $tmpState
	    echo "job script = $jobScript"
	    head -1 $tmpState | grep -q "Submitted batch job" || ERROR "Unable to submit batch job"
	    jobId=`head -1 $tmpState | awk '{print $4}'`
	    if [ $jobId -le 0 ];then
		ERROR "Invalid jobID"
	    fi
	    rm $tmpState
	    echo "Batch job $jobId submitted"
	    rc=1
	    for i in `seq 1 3000`; do
		if ! tmpState=$(scontrol show job $jobId | grep JobState) ; then
		    ERROR_RETURN "Error querying job"
		fi
		if echo	 "$tmpState" | egrep -q "JobState=COMPLETED" ; then
		    echo "Job completed..."
		    rc=0
		    break
		elif echo "$tmpState" | egrep -q "JobState=FAILED" ; then
		    local tmpReason=$(scontrol show job $jobId | grep Reason | awk '{print $2}')
		    echo " "
		    echo "Job $jobId failed..."
		    echo "$tmpReason"
		    break
		elif echo "$tmpState" | egrep -q "JobState=TIMEOUT" ; then
		    local tmpReason=$(scontrol show job $jobId | grep Reason | awk '{print $2}')
		    echo " "
		    echo "Job $jobId encountered timeout..."
		    echo "$tmpReason"
		    break
		elif echo "$tmpState" | egrep -q "JobState=CANCELLED" ; then
		    echo " "
		    echo "Job $jobId cancelled..."
		    break
		else
		    sleep 1
		fi
	    done
	    # Look for evidence of failure in job output
	    echo " "
	    cat job.$jobId.out
	    if egrep -q "$jobId FAILED|$jobId CANCELLED|exited on signal|command not found|failed to start|Unable to access executable|Error in init phase" job.$jobId.out ; then
		rc=1
	    fi
	    if [ -n "$output_file" ];then
		mv job.$jobId.out $output_file
	    fi
	    rm $jobScript
	    return $rc
	else
	    ERROR_RETURN "Unsupported MPI family"
	fi
    elif [ "$RESOURCE_MANAGER" = "openpbs" ];then
	jobScript=/tmp/job.$USER.$RANDOM
	# infer tasks/node from total tasks
	let tasksPerNode="$NTASKS / $NNODES"
	echo "#!/bin/bash"		                      > $jobScript
	echo "#PBS -N OpenHPC-test"                          >> $jobScript
	#	echo "#PBS -lnodes=$NNODES:ppn=$tasksPerNode"        >> $jobScript
	echo "#PBS -l select=$NNODES:mpiprocs=$tasksPerNode -l place=scatter" >> $jobScript
	echo "#PBS -l walltime=$timeout"                     >> $jobScript
	echo "#PBS -l place=excl"                            >> $jobScript
	echo "#PBS -o job.out"                               >> $jobScript
	echo "cd \$PBS_O_WORKDIR"                            >> $jobScript
	if [ -n "$input_file" ];then
	    echo "$mpi_launcher $EXE $ARGS < $input_file" >> $jobScript
	else
	    echo "$mpi_launcher $EXE $ARGS"		  >> $jobScript
	fi
	# Submit batch job
	qsub -W block=true $jobScript
	rc=$?
	if [ -n "$output_file" ];then
	    if [ "$output_file" != "job.out" ];then
		mv job.out $output_file
	    fi
	fi
	return $rc
    else
	ERROR_RETURN "Unsupported resource manager"
    fi
} # end run_mpi_binary()
get_rpm_name () {
    local family
    if  [[ "${LMOD_FAMILY_COMPILER}" =~ "acfl" ]]; then
        # The arm compiler package set "acfl".
        # OpenHPC expects "arm1".
        family="arm1"
    else
        family="${LMOD_FAMILY_COMPILER}"
    fi
    if [ -n "${LMOD_FAMILY_MPI}" ]; then
        echo "${1}-${family}-${LMOD_FAMILY_MPI}${DELIM}"
    else
        echo "${1}-${family}${DELIM}"
    fi
}
