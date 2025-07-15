#!/bin/bash
#FLUX: --job-name=misunderstood-lizard-7882
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

mkdir -p logs
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPT_DIR}" == *"slurmd"* ]] && TOP_DIR=${SLURM_SUBMIT_DIR} || TOP_DIR=$(realpath -es "${SCRIPT_DIR}/..")
else
    TOP_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && git rev-parse --show-toplevel)"
fi
INCLUDE_DIR=$(realpath -es "${TOP_DIR}/scripts/include")
[ ! -d "${INCLUDE_DIR}" ]           && echo "Cannot find include directory: exiting" && exit 1
[ -f "${INCLUDE_DIR}/common.bash" ] && source ${INCLUDE_DIR}/common.bash
parse_command_line $*
module purge || print_error_and_exit "Unable to find the module command"
if [ -f "${SETTINGS_DIR}/aion.sh" ]; then
    source ${SETTINGS_DIR}/aion.sh
fi
use_swset_modules ${USE_SWSET_VERSION}
module load tools/EasyBuild || print_error_and_exit "Unable to load EB module 'tools/EasyBuild'"
run_build
