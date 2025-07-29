#!/bin/bash
#FLUX: --job-name=RESIF-Prod-CPU-broadwell
#FLUX: -c=7
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=100

mkdir -p logs
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPT_DIR}" == *"slurmd"* ]] && TOP_DIR=${SLURM_SUBMIT_DIR} || TOP_DIR=$(realpath -es "${SCRIPT_DIR}/../..")
else
    TOP_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && git rev-parse --show-toplevel)"
fi
INCLUDE_DIR=$(realpath -es "${TOP_DIR}/scripts/include")
[ ! -d "${INCLUDE_DIR}" ]           && echo "Cannot find include directory: exiting" && exit 1
[ -f "${INCLUDE_DIR}/common.bash" ] && source ${INCLUDE_DIR}/common.bash
parse_command_line_prod $*
[ -z "${VERSION}" ] && print_error_and_exit "You **MUST** define the software set version you want to build against"
module purge || print_error_and_exit "Unable to find the module command"
if [ -f "${SETTINGS_DIR}/prod/${VERSION}/iris.sh" ]; then
    source ${SETTINGS_DIR}/prod/${VERSION}/iris.sh
fi
module load tools/EasyBuild || print_error_and_exit "Unable to load EB module 'tools/EasyBuild'"
run_build
