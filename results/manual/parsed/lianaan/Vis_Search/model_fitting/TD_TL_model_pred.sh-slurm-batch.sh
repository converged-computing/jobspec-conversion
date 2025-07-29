#!/bin/bash
#SBATCH --job-name=TD_TL_model_pred
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=alm652@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=2-10:00:00
#SBATCH --constraint=ntasks-per-node=1

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
TD_TL_model_pred($IID);
EOF
