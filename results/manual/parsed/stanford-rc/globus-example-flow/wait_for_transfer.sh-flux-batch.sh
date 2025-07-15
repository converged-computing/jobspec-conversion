#!/bin/bash
#FLUX: --job-name=phat-citrus-5099
#FLUX: -t=900
#FLUX: --urgency=16

module load system py-globus-cli/1.9.0_py36
if [ $# -ne 1 ]; then
    echo 'ERROR!  The number of arguments should be only 1.'
    exit 1
fi
transfer_id_file=$1
if [ ! -f ${transfer_id_file} ]; then
    echo "ERROR! ${transfer_id_file} is not a file."
    exit 1
fi
transfer_id=$(cat ${transfer_id_file})
output=$(globus task show --jmespath status ${transfer_id} 2>&1)
output_code=$?
if [ $output_code -ne 0 ]; then
    echo "ERROR!  The transfer ID ${transfer_id} is not valid."
    echo $output
    exit 1
else
    globus_task_status="${output}"
fi
do_requeue() {
    scontrol requeue $SLURM_JOBID
    return
}
trap 'do_requeue' SIGUSR1
while [ $globus_task_status = '"ACTIVE"' ]; do
    # Wait for 30 seconds.  This is good to do at the start of the loop,
    # because the transfer was probably just submitted, and it's unlikely that
    # it completed so quickly.
    sleep 30
    # Pull the status of the task.
    globus_task_status=$(globus task show --jmespath status ${transfer_id} 2>&1)
    output_code=$?
    # If the output code is non-zero, say something and exit.
    if [ $output_code -ne 0 ]; then
        echo 'ERROR!  The globus task show command failed.'
        echo "${globus_task_status}"
        exit 1
    fi
    # If the output code is zero, we'll let the loop decide what to do!
done
if [ $globus_task_status = '"SUCCEEDED"' ]; then
    exit 0
fi
echo "Transfer failed.  ${globus_task_status}"
exit 1
