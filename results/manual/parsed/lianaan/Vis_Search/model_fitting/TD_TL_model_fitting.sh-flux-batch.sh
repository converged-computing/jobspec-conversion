#!/bin/bash
#FLUX: --job-name=TD_TL_model_fitting
#FLUX: -t=208800
#FLUX: --urgency=16

export MATLABPATH='${MATLABPATH}:/${HOME}/${NAME}/matlab:${HOME}/MATLAB'

module purge
module load matlab/2015b
export MATLABPATH=${MATLABPATH}:/${HOME}/${NAME}/matlab:${HOME}/MATLAB
source ${HOME}/MATLAB/setpath.sh
if [[ ! -z "$SLURM_ARRAY_TASK_ID" ]]; then
        IID=${SLURM_ARRAY_TASK_ID}
fi
cat<<EOF | matlab -nodisplay
addpath(genpath('${HOME}/MATLAB'));
TD_TL_model_fitting($IID);
EOF
