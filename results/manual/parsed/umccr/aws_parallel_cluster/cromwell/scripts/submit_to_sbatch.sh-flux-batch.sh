#!/bin/bash
#FLUX: --job-name=moolicious-kerfuffle-0647
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

: '
This slurm template is designed to pull down a container from dockerhub.com
And then run it through srun
Do this in two separate steps so the pull and run can be captured in separate slurm accounting
'
echo_stderr () {
    # Write echo to stderr
    echo "${@}" >&2
}
sync_filesystem() {
  # sync a specific filesystem
  local filesystem="$1"
  docker run \
  --rm \
  --volume "${PWD}:${PWD}" \
  --workdir "${PWD}" \
    alpine:latest sync -f "${filesystem}"
}
cleanup() {
    # Used by trap to ensure the image and tmp directories are deleted
    # Ideally we wouldn't have to submit another job
    # But slurm only gives us 90 seconds and this can take a few minutes to complete
    err="$?"
    echo_stderr "Cleaning things up after err ${err}"
    # Clean up the local diskspace
    fuser -TERM -k "${BUILD_LOG_STDOUT}.fifo"; fuser -TERM -k "${BUILD_LOG_STDERR}.fifo";
    fuser -TERM -k "${EXEC_LOG_STDOUT}.fifo"; fuser -TERM -k "${EXEC_LOG_STDERR}.fifo"
    fuser -TERM -k "${SBATCH_STDOUT}.fifo"; fuser -TERM -k "${SBATCH_STDERR}.fifo";
    rm -f "${BUILD_LOG_STDOUT}.fifo" "${BUILD_LOG_STDOUT}.fifo";
    rm -f "${EXEC_LOG_STDOUT}.fifo" "${EXEC_LOG_STDOUT}.fifo";
    rm -f "${SBATCH_STDOUT}.fifo" "${SBATCH_STDERR}.fifo";
    mv "${SBATCH_STDOUT}" "${SBATCH_STDERR}" "execution/";
    mv "${BUILD_LOG_STDOUT}" "${BUILD_LOG_STDERR}" "execution/";
    mv "${EXEC_LOG_STDOUT}" "${EXEC_LOG_STDERR}" "execution/";
    # Sync the execution filesystem
    sync_filesystem execution/
    # Delete the shared /tmp dir
    rm -rf "${SHARED_DIR}"
    # Exit with the initial exit code
    exit "${err}"
}
: '
The following env vars should exist
IMAGE_PATH - The path to the docker image (on dockerhub.com)
CWD - The working directory of the task
DOCKER_CWD - The working directory inside docker
JOB_SHELL - The job shell - likely bash
SCRIPT_PATH - Path to the script
'
if [[ ! -v IMAGE_PATH ]]; then
  echo_stderr "Error could not find variable IMAGE_PATH, exiting"
  exit 1
fi
if [[ ! -v CWD ]]; then
  echo_stderr "Error could not find variable CWD, exiting"
  exit 1
fi
if [[ ! -v DOCKER_CWD ]]; then
  echo_stderr "Error could not find variable DOCKER_CWD, exiting"
  exit 1
fi
if [[ ! -v JOB_SHELL ]]; then
  echo_stderr "Error could not find variable JOB_SHELL, exiting"
  exit 1
fi
if [[ ! -v SCRIPT_PATH ]]; then
  echo_stderr "Error could not find variable SCRIPT_PATH, exiting"
  exit 1
fi
if [[ ! -v DOCKER_SCRIPT_PATH ]]; then
  echo_stderr "Error could not find variable SCRIPT_PATH, exiting"
  exit 1
fi
: '
Set globals not set in environment
'
DOCKER_TMPDIR="/scratch"
: '
Here we check that the environment variables that should be here are here.
Then we build the container - looking out for any common errors along the way.
'
set -eE
if [[ ! -v SLURM_JOB_ID || ! -v SLURM_NODELIST ]]; then
        exit 21
fi
if [[ ! -v SLURM_CPUS_PER_TASK || ! -v SLURM_MEM_PER_CPU ]]; then
        exit 22
fi
scontrol write batch_script "${SLURM_JOB_ID}" 1>&2
mv "slurm-${SLURM_JOB_ID}.sh" execution/
if [[ ! -v SLURM_RESTART_COUNT ]]; then
        SLURM_RESTART_COUNT=0
fi
export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK}"
SHARED_DIR="$(mktemp -d --suffix ".cromwell_execution_tmp_slurm_job_id-${SLURM_JOB_ID}")"
BUILD_LOG_DIR="$(mktemp --tmpdir="${SHARED_DIR}" -d "build_log_XXX")"
EXEC_LOG_DIR="$(mktemp --tmpdir="${SHARED_DIR}" -d "exec_log_XXX")"
EXEC_TMP_DIR="$(mktemp --tmpdir="${SHARED_DIR}" -d "exec_tmp_XXX")"
BUILD_LOG_STDOUT="${BUILD_LOG_DIR}/stdout.build.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.log"
BUILD_LOG_STDERR="${BUILD_LOG_DIR}/stderr.build.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.log"
EXEC_LOG_STDOUT="${EXEC_LOG_DIR}/stdout.exec.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.log"
EXEC_LOG_STDERR="${EXEC_LOG_DIR}/stderr.exec.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.log"
SBATCH_STDOUT="${EXEC_LOG_DIR}/stdout.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.batch"
SBATCH_STDERR="${EXEC_LOG_DIR}/stderr.${SLURM_JOB_ID}.${SLURM_RESTART_COUNT}.batch"
mkfifo "${BUILD_LOG_STDOUT}.fifo" "${BUILD_LOG_STDERR}.fifo"
mkfifo "${EXEC_LOG_STDOUT}.fifo" "${EXEC_LOG_STDERR}.fifo"
mkfifo "${SBATCH_STDOUT}.fifo" "${SBATCH_STDERR}.fifo"
trap cleanup EXIT
tee "${SBATCH_STDOUT}" < "${SBATCH_STDOUT}.fifo" &
tee "${SBATCH_STDERR}" < "${SBATCH_STDERR}.fifo" >&2 &
(
    # Use sed to switch to local disk space instead of shared filesystem
    sed -i "s%tmpDir=.*%tmpDir=\"${DOCKER_TMPDIR}\"%" "${SCRIPT_PATH}"
    # Delete globs (may exist from a requeue)
    find execution/ -maxdepth 1 -name 'glob-*' -exec rm -rf "{}" \;
    # Use tee/fifo combo to ensure we have a permanent record of this build.
    # We also capture the process ID and continuously monitor it.
    tee "${BUILD_LOG_STDOUT}" < "${BUILD_LOG_STDOUT}.fifo" &
    tee "${BUILD_LOG_STDERR}" < "${BUILD_LOG_STDERR}.fifo" >&2 &
    (
        srun \
          --export=ALL \
          --ntasks="1" \
          --job-name="docker_pull" \
          docker pull \
            "${IMAGE_PATH}"
    ) > "${BUILD_LOG_STDOUT}.fifo" 2> "${BUILD_LOG_STDERR}.fifo"
    ### RUN SCRIPT ###
    : '
    Now run docker file through srun
    '
    # Run the executable
    # Use tee - to capture stderr and stdout
    tee "${EXEC_LOG_STDOUT}" < "${EXEC_LOG_STDOUT}.fifo" &
    tee "${EXEC_LOG_STDERR}" < "${EXEC_LOG_STDERR}.fifo" >&2 &
    (
        srun \
          --export=ALL \
          --ntasks="1" \
          --job-name="docker_exec" \
          docker run \
            --rm \
            --volume "${EXEC_TMP_DIR}:${DOCKER_TMPDIR}" \
            --volume "${CWD}:${DOCKER_CWD}" \
            --volume "/etc/localtime:/etc/localtime" \
            --cpus "${SLURM_CPUS_PER_TASK}" \
            --memory "$((${SLURM_CPUS_PER_TASK}*${SLURM_MEM_PER_CPU}))M" \
            --entrypoint "${JOB_SHELL}" \
            "${IMAGE_PATH}" \
              "${DOCKER_SCRIPT_PATH}"
    ) > "${EXEC_LOG_STDOUT}.fifo" 2> "${EXEC_LOG_STDERR}.fifo"
    ### END OF RUN SCRIPT ###
) > "${SBATCH_STDOUT}.fifo" 2> "${SBATCH_STDERR}.fifo"
rm -f "${BUILD_LOG_STDOUT}.fifo" "${BUILD_LOG_STDOUT}.fifo";
rm -f "${EXEC_LOG_STDOUT}.fifo" "${EXEC_LOG_STDOUT}.fifo";
rm -f "${SBATCH_STDOUT}.fifo" "${SBATCH_STDERR}.fifo";
mv "${SBATCH_STDOUT}" "${SBATCH_STDERR}" "execution/";
mv "${BUILD_LOG_STDOUT}" "${BUILD_LOG_STDERR}" "execution/";
mv "${EXEC_LOG_STDOUT}" "${EXEC_LOG_STDERR}" "execution/";
set +e
sync_filesystem execution/
set -e
rm -rf "${SHARED_DIR}"
trap - EXIT
