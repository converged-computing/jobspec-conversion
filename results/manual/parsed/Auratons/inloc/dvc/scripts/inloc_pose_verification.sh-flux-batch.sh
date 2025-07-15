#!/bin/bash
#FLUX: --job-name=inloc
#FLUX: -c=17
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${CURRENT_DIR}/../../functions/vlfeat/toolbox/mex/mexa64/'

set -e
. /opt/ohpc/admin/lmod/lmod/init/bash
ml purge
module load MATLAB/2019b
module load SuiteSparse/5.1.2-foss-2018b-METIS-5.1.0
nvidia-smi
echo
echo "Running on $(hostname)"
echo "The $(type python)"
echo "Interactive Slurm mode GPU index: ${SLURM_STEP_GPUS}"
echo "Batch Slurm mode GPU index: ${SLURM_JOB_GPUS}"
echo
CONFIG_NAME=${1:-main}
TMP_ENTRYPOINT=$(mktemp)
trap "rm -f ${TMP_ENTRYPOINT}" 0 2 3 15
if [ -n "${SLURM_JOB_ID}" ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    SCRIPT=$(realpath $(scontrol show job ${SLURM_JOBID} | awk -F= '/Command=/{print $2}' | cut -d' ' -f1))
    CURRENT_DIR="$( cd "$( dirname "${SCRIPT}" )" && pwd )"
else
    # otherwise: started with bash. Get the real location.
    CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${CURRENT_DIR}/../../functions/vlfeat/toolbox/mex/mexa64/"
cat > ${TMP_ENTRYPOINT} <<- EOF
params_file = '$(realpath params.yaml)';
experiment_name = '${CONFIG_NAME}';
low = 201
high = 356
run('inloc_all_in_one.m');
EOF
cat "${TMP_ENTRYPOINT}"
echo
cd "${CURRENT_DIR}/../../inLocCIIRC_demo"
cat "${TMP_ENTRYPOINT}" | ~/.homebrew/bin/time -f 'real\t%e s\nuser\t%U s\nsys\t%S s\nmemmax\t%M kB' matlab -nodesktop
