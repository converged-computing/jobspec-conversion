#!/bin/bash
#FLUX: --job-name=loopy-staircase-6036
#FLUX: --queue=normal
#FLUX: -t=10800
#FLUX: --urgency=16

remote_name="${USER}_gcs_backup"
gcs_path="dlab-backup-${USER}"
DEBUG=${DEBUG:=0}
if [ $DEBUG -eq 1 ]; then
	echo 'Debug alive'
fi
TMPDIR=${TMPDIR:=/tmp}
exec 2>&1
function mail_or_print {
	#  $1 = The body of the email
	#  $2 = The subject line of the email
	if [ $DEBUG -eq 1 ]; then
		echo 'In mail_or_print'
	fi
	#  If we are in SLURM, then we need to send an email to the user.
	#  Otherise, simply print the subject and message to the user.
	if [ ${SLURM_JOB_ID:=0} -ne 0 ]; then
		if [ $DEBUG -eq 1 ]; then
			echo 'Sending email'
		fi
		echo "${1}" | mail -s "${2}" $USER
	else
		echo "${2}"
		echo "${1}"
	fi
	return 0
}
function rclone_exit_failed {
	if [ $DEBUG -eq 1 ]; then
		echo "In rclone_exit_failed with exit code ${1}"
	fi
	case $1 in
		1)
			return 0
			;;
		2)
			return 0
			;;
		*)
			return 1
			;;
	esac
}
function rclone_exit_notfound {
	if [ $DEBUG -eq 1 ]; then
		echo "In rclone_exit_notfound with exit code ${1}"
	fi
	case $1 in
		3)
			return 0
			;;
		4)
			return 0
			;;
		*)
			return 1
			;;
	esac
}
function rclone_exit_temporary {
	if [ $DEBUG -eq 1 ]; then
		echo "In rclone_exit_temporary with exit code ${1}"
	fi
	case $1 in
		5)
			return 0
			;;
		8)
			return 0
			;;
		*)
			return 1
			;;
	esac
}
function rclone_exit_permanent {
	if [ $DEBUG -eq 1 ]; then
		echo "In rclone_exit_permanent with exit code ${1}"
	fi
	case $1 in
		6)
			return 0
			;;
		7)
			return 0
			;;
		*)
			return 1
			;;
	esac
}
function exit_rclone_failed {
	if [ $DEBUG -eq 1 ]; then
		echo "In exit_rclone_failed"
		echo "Command is ${1}"
	fi
	IFS='' read -r -d '' error_message <<-EOF
	There was a problem running rclone.  This is either because of a local problem, or because of some other problem that rclone hasn't otherwise classified.  Either way, this program will not work until the underlying problem is fixed.
	The rclone command run was: ${1}
	Here is the output from rclone:
	${2}
EOF
	error_subject='rclone failure [ACTION REQUIRED]'
	mail_or_print "${error_message}" "${error_subject}"
	exit 1
}
function exit_rclone_notfound {
	if [ $DEBUG -eq 1 ]; then
		echo "In exit_rclone_notfound"
		echo "Command is ${1}"
	fi
	IFS='' read -r -d '' error_message <<-EOF
	There was a problem running rclone.  One of the paths wasn't found, either a local path, or a remote path.  Either way, this program will not work until the underlying problem is fixed.
	The rclone command run was: ${1}
	Here is the output from rclone:
	${2}
EOF
	error_subject='rclone path not found [ACTION REQUIRED]'
	mail_or_print "${error_message}" "${error_subject}"
	exit 1
}
function exit_rclone_permanent {
	if [ $DEBUG -eq 1 ]; then
		echo "In exit_rclone_permanent"
		echo "Command is ${1}"
	fi
	IFS='' read -r -d '' error_message <<-EOF
	There was a problem running rclone.  The remote service reported some sort of permanent error.  This is an error that cannot be fixed by just waiting around.  Instead, some action must be taken in order to fix things.  This program will not work until the problem is fixed.
	The rclone command run was: ${1}
	Here is the output from rclone:
	${2}
EOF
	error_subject='rclone remote permanent error [ACTION REQUIRED]'
	mail_or_print "${error_message}" "${error_subject}"
	exit 1
}
function exit_rclone_temporary {
	if [ $DEBUG -eq 1 ]; then
		echo "In exit_rclone_temporary"
		echo "Command is ${1}"
	fi
	IFS='' read -r -d '' error_message <<-EOF
	There was a problem running rclone.  Too many remote operations have been performed, and we have been asked to wait until a later time before doing any more work.
	There is no specific problem to be fixed here.  Instead, just wait a while and re-run the program.
	The rclone command run was: ${1}
	Here is the output from rclone:
	${2}
EOF
	error_subject='rclone remote temporary error [TRY AGAIN LATER]'
	mail_or_print "${error_message}" "${error_subject}"
	exit 1
}
if [ $# -ne 1 ]; then
	echo 'This script got the wrong number of arguments!'
	echo 'You should be running this script with one argument: The name of a file or directory to sync.'
	echo "For example: $0 some_directory"
	exit 1
fi
if [ $DEBUG -eq 1 ]; then
	echo "Loading modules: system rclone/1.55.1"
fi
module load system rclone/1.55.1 2>&1
exit_code=$?
if [ $exit_code -ne 0 ]; then
	IFS='' read -r -d '' error_message <<EOF
The rclone module, and the system module (which rclone requires) could not be loaded.  This either means a problem with your configuration (if you're using a non-default Module program), or the rclone version 1.39 module may be gone (possibly replaced by a newer version?).  Either way, this program will not work until the problem is resolved and the script is updated.
EOF
	error_subject="rclone module load problem [ACTION REQUIRED]"
	mail_or_print "${error_message}" "${error_subject}"
	if [ $DEBUG -eq 1 ]; then
		echo 'ML output:'
		echo $ml_output
	fi
	exit 1
fi
rclone_command=( rclone config show "${remote_name}" )
if [ $DEBUG -eq 1 ]; then
	echo "Checking for config ${remote_name}"
	echo "command: ${rclone_command[@]}"
fi
rclone_output=$("${rclone_command[@]}" 2>&1)
exit_code=$?
if [ $DEBUG -eq 1 ]; then
	echo "command output: ${rclone_output}"
fi
if [ $exit_code -ne 0 ]; then
	IFS='' read -r -d '' error_message <<EOF
Your rclone configuration is missing a "$remote_name" remote.  That normally means that you need to do some setup work before running this job.  This program will not work until the remote is set up.  Check with your Lab Manager, or a lab-mate, for information on how to set up the remote!
For reference, your job was attempting to back up this path: ${1}
The above path is relative to the following location: ${PWD}
EOF
	error_subject='rclone configuration problem [ACTION REQUIRED]'
	mail_or_print "${error_message}" "${error_subject}"
	exit 1
fi
if [ $DEBUG -eq 1 ]; then
	echo "Checking source path: ${1}"
fi
stat $1 > /dev/null 2>&1
exit_code=$?
if [ $exit_code -ne 0 ]; then
	IFS='' read -r -d '' error_message <<EOF
The source path "$1" is not accessible.  It may be that the directory has been moved, or renamed.  Or maybe you did not provide a source path?  (It should be the first argument after the script.)  Either way, this program will not work anymore.  You should try re-submitting it with a new path.
For reference, the source path above was relative to the following location: ${PWD}
EOF
	error_subject='rclone source path problem [ACTION REQUIRED]'
	mail_or_print "${error_message}" "${error_subject}"
	if [ $DEBUG -eq 1 ]; then
		echo 'stat output:'
		stat $1 2>&1
	fi
	exit 1
fi
rclone_command=( rclone ls "${remote_name}:" --max-depth 1 )
if [ $DEBUG -eq 1 ]; then
	echo 'Checking destination path'
	echo "command: ${rclone_command[@]}"
fi
rclone_output=$("${rclone_command[@]}" 2>&1)
exit_code=$?
if rclone_exit_temporary "${exit_code}"; then
	# If we are running interactively, then just ask the user to wait.
	# Otherwise, try running again in 15+ minutes.
	if [ ${SLURM_JOB_ID:=0} -eq 0 ]; then
		exit_rclone_temporary "${rclone_command[*]}" "${rclone_output}"
	else
		exec sbatch --quiet --job-name "Backup ${1}" --begin 'now+15minutes' $0 $@
	fi
fi
if rclone_exit_failed "${exit_code}"; then
	exit_rclone_failed "${rclone_command[*]}" "${rclone_output}"
fi
if rclone_exit_notfound "${exit_code}"; then
	exit_rclone_notfound "${rclone_command[*]}" "${rclone_output}"
fi
if rclone_exit_permanent "${exit_code}"; then
	exit_rclone_permanent "${rclone_command[*]}" "${rclone_output}"
fi
rclone_command=(rclone ls "${remote_name}:${gcs_path}" --max-depth 1)
if [ $DEBUG -eq 1 ]; then
	echo 'Checking destination base path'
	echo "command: ${rclone_command[@]}"
fi
rclone_output=$("${rclone_command[@]}" 2>&1)
exit_code=$?
if rclone_exit_temporary "${exit_code}"; then
	# If we are running interactively, then just ask the user to wait.
	# Otherwise, try running again in 15+ minutes.
	if [ ${SLURM_JOB_ID:=0} -eq 0 ]; then
		exit_rclone_temporary "${rclone_command[*]}" "${rclone_output}"
	else
		exec sbatch --quiet --job-name "Backup ${1}" --begin 'now+15minutes' $0 $@
	fi
fi
if rclone_exit_failed "${exit_code}"; then
	exit_rclone_failed "${rclone_command[*]}" "${rclone_output}"
fi
if rclone_exit_notfound "${exit_code}"; then
	exit_rclone_notfound "${rclone_command[*]}" "${rclone_output}"
fi
if rclone_exit_permanent "${exit_code}"; then
	exit_rclone_permanent "${rclone_command[*]}" "${rclone_output}"
fi
if [ ${SLURM_JOB_ID:=0} -eq 0 ]; then
	cat - <<EOF
Good to go!
Attempting to submit a job.
After this, you will either get a job ID number, or an error.
If you get a job ID number, all further messages should come to you by email!
EOF
	exec sbatch --job-name="Backup ${1}" --begin=now $0 $@
fi
remote_path=$(echo "${remote_name}:${gcs_path}/${1}" | tr -s /)
if [ $DEBUG -eq 1 ]; then
	echo "Using remote_path ${remote_path}"
fi
rclone_pid=0
rclone_output_file="${TMPDIR}/rclone.${SLURM_JOBID}.out"
if [ $DEBUG -eq 1 ]; then
	echo "rclone output will be sent to path ${rclone_output_file}"
fi
function signal_usr1 {
	if [ $DEBUG -eq 1 ]; then
		echo 'Received USR1 signal.  Our time has run out.'
	fi
	# Since we'll be killing rclone, unlink our temp file.
	if [ -f ${rclone_output_file} ]; then
		rm ${rclone_output_file}
	fi
	#  Kill the rclone process, and then requeue ourselves.
	#  NOTE: We use `requeue` here so that all of the executions appear under
	#+ the same jobid, which helps with future lookups via `sacct`.
	kill $rclone_pid
	exec scontrol requeue ${SLURM_JOBID}
}
function signal_int {
	if [ $DEBUG -eq 1 ]; then
		echo 'Received INT signal.  Killing child process and cleaning up.'
	fi
	# Since we'll be killing rclone, unlink our temp file.
	if [ -f ${rclone_output_file} ]; then
		rm ${rclone_output_file}
	fi
	# Kill the rclone process, and then exit ourselves.
	kill $rclone_pid
	exit 1
}
trap "signal_usr1 $@" USR1
trap "signal_int $@" INT
if [ $DEBUG -eq 1 ]; then
	echo "Running rclone sync '$1' '${remote_path}'"
fi
(
	exec 1>${rclone_output_file} 2>&1
	exec rclone sync "${1}" "${remote_path}"
) &
rclone_pid=$!
if [ $DEBUG -eq 1 ]; then
	echo "rclone launched with PID ${rclone_pid}.  Waiting..."
fi
wait $rclone_pid
exit_code=$?
rclone_output=$(cat ${rclone_output_file})
if rclone_exit_temporary "${exit_code}"; then
	#  We are not running interactively now, so our next action is always going
	#+ to be to resubmit ourselves.
	exec sbatch --quiet --job-name "Backup ${1}" --begin 'now+15minutes' $0 $@
fi
if rclone_exit_failed "${exit_code}"; then
	exit_rclone_failed "${rclone_command[*]}" "${rclone_output}"; exit $?
fi
if rclone_exit_notfound "${exit_code}"; then
	exit_rclone_notfound "${rclone_command[*]}" "${rclone_output}"; exit $?
fi
if rclone_exit_permanent "${exit_code}"; then
	exit_rclone_permanent "${rclone_command[*]}" "${rclone_output}"; exit $?
fi
if [ $DEBUG -eq 1 ]; then
	echo "Sync complete!  Sending mail and scheduling to run again tomorrow."
fi
IFS='' read -r -d '' completion_message <<EOF
Your backup of path ${1} has been completed without errors!
The output of the \`rclone\` command is attached.  Please check it for problems.
EOF
echo "${completion_message}" | mail -s "Backup completed for ${1}" -a ${rclone_output_file} ${USER}
rm ${rclone_output_file}
exec sbatch --quiet --job-name "Backup ${1}" --begin 'now+1day' $0 $@
