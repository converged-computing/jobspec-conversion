#!/bin/bash

#FLUX: --job-name=Act_tanh_1
#FLUX: -n 1                                 # Number of tasks (processes)
#FLUX: -c 1                                 # Number of cores per task
#FLUX: --requires=mem=6000M                 # Memory required per task (6000MB)
#FLUX: -t 23h59m00s                         # Walltime (23 hours, 59 minutes, 0 seconds)

# --- Configuration for logging and mail ---
LOG_DIR="/work/scratch/se55gyhe/log"
MAIL_USER="eger@ukp.informatik.tu-darmstadt.de"
# Use the original Slurm job name or Flux job name for email subject clarity
JOB_NAME_FOR_MAIL="${FLUX_JOB_NAME:-Act_tanh_1}"


# --- Setup logging directory and redirection ---
# Ensure the log directory exists
mkdir -p "${LOG_DIR}"

# Standard output and error files. FLUX_JOB_ID is set by Flux at runtime.
# Using :-local as a fallback if FLUX_JOB_ID is not set (e.g., for local testing)
STDOUT_FILE="${LOG_DIR}/output.out.${FLUX_JOB_ID:-local}"
STDERR_FILE="${LOG_DIR}/output.err.${FLUX_JOB_ID:-local}"

# Redirect stdout and stderr for the rest of the script
exec > "${STDOUT_FILE}" 2> "${STDERR_FILE}"


# --- Mail notification on FAIL ---
# This function will be called if the script exits with a non-zero status
# due to an error, triggered by the 'trap' command.
# Note: The 'mail' command's availability and syntax might vary by system.
send_failure_mail() {
    local job_id_for_mail="${FLUX_JOB_ID:-UNKNOWN_FLUX_JOB_ID}"
    local subject="Flux Job FAILED: ${JOB_NAME_FOR_MAIL} (ID: ${job_id_for_mail})"
    local body="Flux job ${JOB_NAME_FOR_MAIL} (ID: ${job_id_for_mail}) failed on host $(hostname).

Error log is available at: ${STDERR_FILE}
Output log is available at: ${STDOUT_FILE}

Check the error log for details."

    # Attempt to send mail. Errors during mailing itself are ignored here.
    echo "${body}" | mail -s "${subject}" "${MAIL_USER}" >/dev/null 2>&1 || \
        echo "Warning: Failed to send failure notification email to ${MAIL_USER}."
}

# Set the script to exit immediately if a command exits with a non-zero status.
set -e

# Trap the ERR signal (any error that would cause the script to exit)
# and call send_failure_mail.
trap send_failure_mail