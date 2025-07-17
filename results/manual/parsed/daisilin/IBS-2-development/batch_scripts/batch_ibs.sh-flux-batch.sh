#!/bin/bash
#FLUX: --job-name=ibs
#FLUX: -t=172800
#FLUX: --urgency=16

export MATLABPATH='$HOME/${PROJECT_FOLDER}/matlab'

PROJECT_FOLDER="IBS-2-development"
model=psycho
proc_id=${SLURM_ARRAY_TASK_ID}
alpha=1
method=ibs_3
if [ $method = "exact" ]; then
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}
else
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}${Nsamples}
fi
module purge. 
module load matlab/2020b
export MATLABPATH=$HOME/${PROJECT_FOLDER}/matlab
mkdir $SCRATCH/${PROJECT_FOLDER}/results
mkdir $SCRATCH/${PROJECT_FOLDER}/results/${model}
mkdir $workdir
cd $workdir
echo $model $method $Nsamples $proc_id
echo "addpath('$SCRATCH/${PROJECT_FOLDER}/matlab/'); recover_theta('${model}','${method}','${alpha}',${proc_id},${Nsamples}); exit;" 
cat<<EOF | matlab -nodisplay
%job_id = str2num(strjoin(regexp('$proc_id','\d','match'), ''))
job_id = str2num('$proc_id')
alpha = str2num('$alpha')
recover_theta('psycho','ibs_3', alpha,job_id)
EOF
