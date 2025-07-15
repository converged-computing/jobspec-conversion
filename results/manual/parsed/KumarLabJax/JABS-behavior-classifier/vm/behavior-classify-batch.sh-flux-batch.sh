#!/bin/bash
#FLUX: --job-name=behavior-classify
#FLUX: -t=3600
#FLUX: --priority=16

CLASSIFICATION_IMG=/projects/kumar-lab/JABS/JABS-Classify-current.sif
trim_sp() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}
MAX_POSE_VERSION=5
MIN_POSE_VERSION=2
find_pose_file() {
    local in_file="$*"
    if [[ "${in_file##*.}" == 'h5' ]]; then
        echo -n ${in_file}
    else
        cur_pose_version=${MAX_POSE_VERSION}
        prefix="${in_file%.*}"
        while [[ cur_pose_version -gt ${MIN_POSE_VERSION} ]]
        do
            if [[ -f "${prefix}_pose_est_v${cur_pose_version}.h5" ]]; then
                echo -n "${prefix}_pose_est_v${cur_pose_version}.h5"
                break
            else
                ((cur_pose_version--))
            fi
        done
    fi
}
if [[ -z "${SLURM_JOB_ID}" ]]
then
    # The script is being run from command line. We should do a self-submit as an array job
    if [[ ( -f "${1}" ) && ( -f "${2}" ) ]]
    then
        # echo "${1} is set and not empty"
        echo "Preparing to submit classification using ${1} on batch file: ${2}"
        batch_line_count=$(wc -l < "${2}")
        echo "Submitting an array job for ${batch_line_count} videos"
        # Here we perform a self-submit
        sbatch --export=CLASSIFIER_FILE="${1}",BATCH_FILE="${2}" --array="1-${batch_line_count}%500" "${0}"
    else
        echo "ERROR: missing classification and/or batch file." >&2
        echo "Expected usage:" >&2
        echo "behavior-classify-batch.sh CLASSIFIER.h5 BATCH_FILE.txt" >&2
        exit 1
    fi
else
    # the script is being run by slurm
    if [[ -z "${SLURM_ARRAY_TASK_ID}" ]]
    then
        echo "ERROR: no SLURM_ARRAY_TASK_ID found. This job should be run as an array" >&2
        exit 1
    fi
    if [[ -z "${CLASSIFIER_FILE}" ]]
    then
        echo "ERROR: the CLASSIFIER_FILE environment variable is not defined" >&2
        exit 1
    fi
    if [[ -z "${BATCH_FILE}" ]]
    then
        echo "ERROR: the BATCH_FILE environment variable is not defined" >&2
        exit 1
    fi
    # here we use the array ID to pull out the right line from the batch file
    BATCH_LINE=$(trim_sp $(sed -n "${SLURM_ARRAY_TASK_ID}{p;q;}" < "${BATCH_FILE}"))
    echo "BATCH LINE FILE: ${BATCH_LINE}"
    # Try and trim the line to look like a video file (if it is a pose file)
    VIDEO_FILE=$(sed -E 's:(_pose_est_v[0-9]+)?\.(avi|h5):.avi:' <(echo ${BATCH_LINE}))
    # the "v1" is for output format versioning. If format changes this should be updated
    OUT_DIR="${VIDEO_FILE%.*}_behavior/v1"
    # The batch file can either contain fully qualified paths for files to process OR local paths relative to where the batch file exists
    # Change the working directory to support local paths
    cd "$(dirname "${BATCH_FILE}")"
    # Detect the pose file based on the batch line provided
    POSE_FILE=$(find_pose_file ${BATCH_LINE})
    if [[ ! ( -f "${POSE_FILE}" ) ]]
    then
        echo "ERROR: failed to find pose file for ${BATCH_LINE}" >&2
        exit 1
    fi
    echo "DUMP OF CURRENT ENVIRONMENT:"
    env
    echo "BEGIN PROCESSING: ${POSE_FILE} for ${BATCH_LINE} (${POSE_FILE}"
    module load singularity
    singularity run "${CLASSIFICATION_IMG}" classify --training "${CLASSIFIER_FILE}" --input-pose "${POSE_FILE}" --out-dir "${OUT_DIR}"
    echo "FINISHED PROCESSING: ${POSE_FILE}"
fi
