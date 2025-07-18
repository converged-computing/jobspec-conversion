#!/bin/bash
#FLUX: --job-name=infer-corners
#FLUX: -c=10
#FLUX: -t=21600
#FLUX: --urgency=15

export PATH='/opt/singularity/bin:${PATH}'

trim_sp() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}
export PATH="/opt/singularity/bin:${PATH}"
if [[ -n "${SLURM_JOB_ID}" ]]
then
    # the script is being run by slurm
    if [[ -n "${SLURM_ARRAY_TASK_ID}" ]]
    then
        if [[ -n "${BATCH_FILE}" ]]
        then
            # here we use the array ID to pull out the right video
            VIDEO_FILE=$(trim_sp $(sed -n "${SLURM_ARRAY_TASK_ID}{p;q;}" < "${BATCH_FILE}"))
            cd "$(dirname "${BATCH_FILE}")"
            if [[ -f "${VIDEO_FILE}" ]]
            then
                echo "${VIDEO_FILE}"
                echo "DUMP OF CURRENT ENVIRONMENT:"
                env
                echo "BEGIN PROCESSING: ${VIDEO_FILE}"
                CORNERS_FILE="${VIDEO_FILE%.*}_corners_v2.yaml"
                module load singularity
                singularity run --nv "${ROOT_DIR}/corner-detection-2021-08-25.sif" "${VIDEO_FILE}"
                # Retry several times if we have to. Unfortunately this is needed because
                # ffmpeg will sporadically give the following error on winter:
                #       ffmpeg: symbol lookup error: /.singularity.d/libs/libGL.so.1: undefined symbol: _glapi_tls_Current
                #
                # You can test this by simply running:
                #       singularity exec --nv corner-detection-2021-08-25.sif ffmpeg
                #
                # which will fail about 1 out of 10 times or so. I (Keith) haven't been able to
                # figure out a solution for this except for retrying several times.
                MAX_RETRIES=10
                for (( i=0; i<"${MAX_RETRIES}"; i++ ))
                do
                    if [[ ! -f "${CORNERS_FILE}" ]]
                    then
                        echo "WARNING: FAILED TO GENERATE OUTPUT FILE. RETRY ATTEMPT ${i}"
                        singularity run --nv "${ROOT_DIR}/corner-detection-2021-08-25.sif" "${VIDEO_FILE}"
                    fi
                done
                if [[ ! -f "${CORNERS_FILE}" ]]
                then
                    echo "ERROR: FAILED TO GENERATE OUTPUT FILE WITH NO MORE RETRIES"
                fi
                echo "FINISHED PROCESSING: ${VIDEO_FILE}"
            else
                echo "ERROR: could not find video file: ${VIDEO_FILE}" >&2
            fi
        else
            echo "ERROR: the BATCH_FILE environment variable is not defined" >&2
        fi
    else
        echo "ERROR: no SLURM_ARRAY_TASK_ID found" >&2
    fi
else
    # the script is being run from command line. We should do a self-submit as an array job
    if [[ -f "${1}" ]]
    then
        # echo "${1} is set and not empty"
        echo "Preparing to submit batch file: ${1}"
        test_count=$(wc -l < "${1}")
        echo "Submitting an array job for ${test_count} videos"
        # Here we perform a self-submit
        echo sbatch --export=ROOT_DIR="$(dirname "${0}")",BATCH_FILE="${1}" --array="1-${test_count}%24" "${0}"
        sbatch --export=ROOT_DIR="$(dirname "${0}")",BATCH_FILE="${1}" --array="1-${test_count}%24" "${0}"
    else
        echo "ERROR: you need to provide a batch file to process. Eg: ./infer-corners-batch.sh batchfile.txt" >&2
        exit 1
    fi
fi
