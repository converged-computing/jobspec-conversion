#!/bin/bash
#FLUX: --job-name=h-1.1
#FLUX: --queue=main
#FLUX: -t=43200
#FLUX: --urgency=16

export VF_OLD_JOB_NO='${jobname:2}'
export VF_VF_OLD_JOB_NO_2='${VF_OLD_JOB_NO/*.}'
export VF_QUEUE_NO_1='${VF_OLD_JOB_NO/.*}'
export VF_JOBLINE_NO='${VF_QUEUE_NO_1}'
export VF_BATCHSYSTEM='SLURM'
export VF_SLEEP_TIME_1='1'
export VF_STARTINGTIME='`date`'
export VF_START_TIME_SECONDS='$(date +%s)'
export VF_NODES_PER_JOB='${job_line/"#SBATCH --nodes="}'
export LC_ALL='C'
export PATH='./bin:$PATH"           # to give bin priority of system commands, useful for obabel sometimes for example'
export VF_TMPDIR='$(grep -m 1 "^tempdir_default=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')'
export VF_TMPDIR_FAST='$(grep -m 1 "^tempdir_fast=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')'
export VF_TIMELIMIT_SECONDS='$(echo -n "${timelimit}" | awk -F ':' '{print $4 + $3 * 60 + $2 * 3600 + $1 * 3600 * 24}')'
export VF_QUEUES_PER_STEP='${line/"queues_per_step="}'

echo
echo "                    *** Job Information ***                    "
echo "==============================================================="
echo
echo "Environment variables"
echo "------------------------"
env
echo
echo
echo "Job infos by scontrol"
echo "------------------------"
scontrol show job $SLURM_JOB_ID
echo
echo "                    *** Job Output ***                    "
echo "==========================================================="
echo
error_response_std() {
    # Printing some informatoin
    echo "Error was trapped" 1>&2
    echo "Error in bash script $0" 1>&2
    echo "Error on line $1" 1>&2
    echo "Environment variables" 1>&2
    echo "----------------------------------" 1>&2
    env 1>&2
    # Checking error response type
    if [[ "${VF_ERROR_RESPONSE}" == "ignore" ]] || [[ "${VF_ERROR_RESPONSE}" == "next_job" ]]; then
        # Printing some information
        echo -e "\n * Trying to continue..."
    elif [[ "${VF_ERROR_RESPONSE}" == "fail" ]]; then
        # Printing some information
        echo -e "\n * Trying to stop this queue and causing the jobline to fail..."
        print_job_infos_end
        # Exiting
        exit 1
    fi
}
trap 'error_response_std $LINENO' ERR
time_near_limit() {
    echo "The script ${BASH_SOURCE[0]} caught a time limit signal. Trying to start a new job."
}
trap 'time_near_limit' 10
termination_signal() {
    echo "The script ${BASH_SOURCE[0]} caught a termination signal. Stopping jobline."
    if [[ "${VF_ERROR_RESPONSE}" == "ignore" ]]; then
        echo -e "\n Ignoring error. Trying to continue..."
    elif [[ "${VF_ERROR_RESPONSE}" == "next_job" ]]; then
        echo -e "\n Ignoring error. Trying to continue and start next job..."
    elif [[ "${VF_ERROR_RESPONSE}" == "fail" ]]; then
        echo -e "\n Stopping the jobline."
        print_job_infos_end
        exit 1
    fi
}
trap 'termination_signal' 1 2 3 9 12 15
print_job_infos_end() {
    # Job information
    echo
    echo "                     *** Final Job Information ***                    "
    echo "======================================================================"
    echo
    echo "Starting time:" $VF_STARTINGTIME
    echo "Ending time:  " $(date)
    echo
}
check_queue_end1() {
    # Determining the VF_CONTROLFILE to use for this jobline
    VF_CONTROLFILE=""
    for file in $(ls ../workflow/control/*-* 2>/dev/null|| true); do
        file_basename=$(basename $file)
        jobline_range=${file_basename/.*}
        VF_JOBLINE_NO_START=${jobline_range/-*}
        VF_JOBLINE_NO_END=${jobline_range/*-}
        if [[ "${VF_JOBLINE_NO_START}" -le "${VF_JOBLINE_NO}" && "${VF_JOBLINE_NO}" -le "${VF_JOBLINE_NO_END}" ]]; then
            export VF_CONTROLFILE="${file}"
            break
        fi
    done
    if [ -z "${VF_CONTROLFILE}" ]; then
        export VF_CONTROLFILE="../workflow/control/all.ctrl"
    fi
    # Checking if the queue should be stopped
    line="$(cat ${VF_CONTROLFILE} | grep "stop_after_next_check_interval=")"
    stop_after_next_check_interval=${line/"stop_after_next_check_interval="}
    if [ "${stop_after_next_check_interval}" = "true" ]; then
        echo
        echo "This job line was stopped by the stop_after_next_check_interval flag in the VF_CONTROLFILE ${VF_CONTROLFILE}."
        echo
        print_job_infos_end
        exit 0
    fi
    # Checking if there are still ligand collections todo
    no_collections_incomplete="0"
    i=0
    # Using a loop to try several times if there are no ligand collections left - maybe the files where just shortly inaccessible
    while [ "${no_collections_incomplete}" == "0" ]; do
        no_collections_incomplete="$(cat ../workflow/ligand-collections/todo/todo.all* ../workflow/ligand-collections/todo/${VF_JOBLINE_NO}/*/* ../workflow/ligand-collections/current/${VF_JOBLINE_NO}/*/* 2>/dev/null | grep -c "[^[:blank:]]" || true)"
        i="$((i + 1))"
        if [ "${i}" == "5" ]; then
            break
        fi
        sleep 1
    done
    if [[ "${no_collections_incomplete}" = "0" ]]; then
        echo
        echo "This job line was stopped because there are no ligand collections left."
        echo
        print_job_infos_end
        exit 0
    fi
}
check_queue_end2() {
    check_queue_end1
    line=$(cat ${VF_CONTROLFILE} | grep "stop_after_job=")
    stop_after_job=${line/"stop_after_job="}
    if [ "${stop_after_job}" = "true" ]; then
        echo
        echo "This job line was stopped by the stop_after_job flag in the VF_CONTROLFILE ${VF_CONTROLFILE}."
        echo
        print_job_infos_end
        exit 0
    fi
}
job_line=$(grep -m 1 "job-name=" $0)
jobname=${job_line/"#SBATCH --job-name="}
export VF_OLD_JOB_NO=${jobname:2}
export VF_VF_OLD_JOB_NO_2=${VF_OLD_JOB_NO/*.}
export VF_QUEUE_NO_1=${VF_OLD_JOB_NO/.*}
export VF_JOBLINE_NO=${VF_QUEUE_NO_1}
export VF_BATCHSYSTEM="SLURM"
export VF_SLEEP_TIME_1="1"
export VF_STARTINGTIME=`date`
export VF_START_TIME_SECONDS="$(date +%s)"
job_line=$(grep -m 1 "nodes=" ../workflow/job-files/main/${VF_JOBLINE_NO}.job)
export VF_NODES_PER_JOB=${job_line/"#SBATCH --nodes="}
export LC_ALL=C
export PATH="./bin:$PATH"           # to give bin priority of system commands, useful for obabel sometimes for example
VF_CONTROLFILE=""
for file in $(ls ../workflow/control/*-* 2>/dev/null|| true); do
    file_basename=$(basename $file)
    jobline_range=${file_basename/.*}
    VF_JOBLINE_NO_START=${jobline_range/-*}
    VF_JOBLINE_NO_END=${jobline_range/*-}
    if [[ "${VF_JOBLINE_NO_START}" -le "${VF_JOBLINE_NO}" && "${VF_JOBLINE_NO}" -le "${VF_JOBLINE_NO_END}" ]]; then
        export VF_CONTROLFILE="${file}"
        break
    fi
done
if [ -z "${VF_CONTROLFILE}" ]; then
    export VF_CONTROLFILE="../workflow/control/all.ctrl"
fi
VF_VERBOSITY_LOGFILES="$(grep -m 1 "^verbosity_logfiles=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
export VF_VERBOSITY_LOGFILES
if [ "${VF_VERBOSITY_LOGFILES}" = "debug" ]; then
    set -x
fi
VF_ERROR_RESPONSE="$(grep -m 1 "^error_response=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
export VF_ERROR_RESPONSE
export VF_TMPDIR="$(grep -m 1 "^tempdir_default=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
if [ ! -d "${VF_TMPDIR}/${USER}" ]; then
    mkdir -p ${VF_TMPDIR}/${USER}
fi
export VF_TMPDIR_FAST="$(grep -m 1 "^tempdir_fast=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
if [ ! -d "${VF_TMPDIR}/${USER}" ]; then
    mkdir -p ${VF_TMPDIR}/${USER}
fi
VF_JOBLETTER="$(grep -m 1 "^job_letter=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
export VF_JOBLETTER
VF_ERROR_SENSITIVITY="$(grep -m 1 "^error_sensitivity=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
export VF_ERROR_SENSITIVITY
if [[ "${VF_ERROR_SENSITIVITY}" == "high" ]]; then
    set -uo pipefail
    trap '' PIPE        # SIGPIPE = exit code 141, means broken pipe. Happens often, e.g. if head is listening and got all the lines it needs.
fi
check_queue_end1
job_line=$(grep -m 1 "time=" ../workflow/job-files/main/${VF_JOBLINE_NO}.job)
timelimit=${job_line/"#SBATCH --time="}
timelimit=${timelimit//-/:}
export VF_TIMELIMIT_SECONDS="$(echo -n "${timelimit}" | awk -F ':' '{print $4 + $3 * 60 + $2 * 3600 + $1 * 3600 * 24}')"
line=$(cat ${VF_CONTROLFILE} | grep "queues_per_step=")
export VF_QUEUES_PER_STEP=${line/"queues_per_step="}
prepare_queue_todolists="$(grep -m 1 "^prepare_queue_todolists=" ${VF_CONTROLFILE} | tr -d '[[:space:]]' | awk -F '[=#]' '{print $2}')"
if [ "${prepare_queue_todolists^^}" == "TRUE" ]; then
    cd helpers
    bash prepare-todolists.sh ${VF_JOBLINE_NO} ${VF_NODES_PER_JOB} ${VF_QUEUES_PER_STEP}
    cd ..
elif [ "${prepare_queue_todolists^^}" == "FALSE" ]; then
    echo " * Skipping the todo-list preparation as specified in the control-file."
else
    echo "Error: The variable prepare_queue_todolists in the control file ${VF_CONTROLFILE} has an unsupported value (${prepare_queue_todolists})."
    false
fi
for VF_STEP_NO in $(seq 1 ${VF_NODES_PER_JOB} ); do
    export VF_STEP_NO
    echo "Starting job step ${VF_STEP_NO} on host $(hostname)."
    srun --relative=$((VF_STEP_NO - 1)) -n 1 -N 1 ../workflow/job-files/sub/one-step.sh &
    pids[$(( VF_STEP_NO - 0 ))]=$!
    sleep "${VF_SLEEP_TIME_1}"
done
exit_code=0
for pid in ${pids[@]}; do
    wait $pid || let "exit_code=1"
done
if [ "$exit_code" == "1" ]; then
    error_response_std $LINENO
fi
echo
echo
echo "                  *** Preparing the next batch system job ***                     "
echo "=================================================================================="
echo
check_queue_end2
cd helpers
. sync-jobfile.sh ${VF_JOBLINE_NO}
cd ..
new_job_no_2=$((VF_VF_OLD_JOB_NO_2 + 1))
new_job_no="${VF_JOBLINE_NO}.${new_job_no_2}"
sed -i "s/^#SBATCH --job-name=${VF_JOBLETTER}.*/#SBATCH --job-name=${VF_JOBLETTER}-${new_job_no}/g" ../workflow/job-files/main/${VF_JOBLINE_NO}.job
sed -i "s|^#SBATCH --output=.*|#SBATCH --output=../workflow/output-files/jobs/job-${new_job_no}_%j.out|g" ../workflow/job-files/main/${VF_JOBLINE_NO}.job
sed -i "s|^#SBATCH --error=.*|#SBATCH --output=../workflow/output-files/jobs/job-${new_job_no}_%j.err|g" ../workflow/job-files/main/${VF_JOBLINE_NO}.job
end_time_seconds="$(date +%s)"
time_diff="$((end_time_seconds - VF_START_TIME_SECONDS))"
treshhold=120
if [ "${time_diff}" -le "${treshhold}" ]; then
    echo "Since the beginning of the job less than ${treshhold} seconds have passed."
    echo "Sleeping for some while to prevent a job submission run..."
    sleep ${treshhold}
fi
cd helpers
. submit.sh ../workflow/job-files/main/${VF_JOBLINE_NO}.job
cd ..
print_job_infos_end
