#!/bin/bash
#FLUX: --job-name=%(step_name)s
#FLUX: --queue=%(partition)s
#FLUX: -t=259200
#FLUX: --urgency=16

export TMPDIR='${HOME}/scratch/tmp'
export SBATCH_DEFAULTS=' --output=${LOGDIR}/%%x-%%j.log'

%(line_m)s
%(line_M)s
set -euo pipefail
umask ug=rwx,o=
MAX_JOBS=500
MAX_JOBS_PER_SECOND=10
RESTART_TIMES=0
test -d slurm_log || { >&2 echo "${PWD}/slurm_log does not exist"; exit 1; }
export TMPDIR=${HOME}/scratch/tmp
mkdir -p ${TMPDIR}
test -z "${SLURM_JOB_ID-}" && SLURM_JOB_ID=$(date +%%Y-%%m-%%d_%%H-%%M)
LOGDIR=slurm_log/${SLURM_JOB_ID}
mkdir -p ${LOGDIR}
export SBATCH_DEFAULTS=" --output=${LOGDIR}/%%x-%%j.log"
conda-in-parent()
{
    current=$PWD
    while [[ -n "$current" ]] && [[ "$current" != "/" ]]; do
        if [[ -e "$current/miniconda3.$USER" ]] && \
                [[ $(stat -c %%u $current/miniconda3.$USER) == $UID ]]; then
            echo "$current/miniconda3.$USER"
            return 0
        fi
        if [[ -e "$current/miniconda3" ]] && \
                [[ $(stat -c %%u $current/miniconda3) == $UID ]]; then
            echo "$current/miniconda3"
            return 0
        fi
        current=$(dirname $current)
    done
    return 1
}
if [[ -n "${CONDA_PATH-}" ]] || CONDA_PATH=$(conda-in-parent); then
    :
elif which conda >/dev/null; then
    CONDA_PATH=$(dirname $(dirname $(which conda)))
elif [[ -e $HOME/miniconda3 ]]; then
    CONDA_PATH=$HOME/miniconda3
elif [[ -e $HOME/work/miniconda3 ]]; then
    CONDA_PATH=$HOME/work/miniconda3
else
    >&2 echo "Could not determine a suitable CONDA_PATH."
    exit 1
fi
>&2 echo "Using conda installation in $CONDA_PATH"
>&2 echo "+ conda activate %(conda)s"
set +euo pipefail
conda deactivate &>/dev/null || true  # disable any existing
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate %(conda)s # enable found
set -euo pipefail
set -x
>&2 hostname
>&2 date
if [[ ! -z "${SNAPPY_BATCH-}" ]]; then
    SNAKEMAKE_BATCH_ARG="--batch ${SNAKEMAKE_BATCH_RULE-default}=${SNAPPY_BATCH}"
else
    SNAKEMAKE_BATCH_ARG=
fi
snappy-snake --printshellcmds \
    ${SNAKEMAKE_BATCH_ARG} \
    --snappy-pipeline-use-profile "cubi-v1" \
    --snappy-pipeline-jobs $MAX_JOBS \
    --restart-times ${RESTART_TIMES} \
    --default-partition="medium" \
    --rerun-incomplete \
    -- \
    $*
>&2 date
>&2 echo "All done. Have a nice day."
