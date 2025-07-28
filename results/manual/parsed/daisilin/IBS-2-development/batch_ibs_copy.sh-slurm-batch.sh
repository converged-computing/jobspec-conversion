#!/bin/bash
#FLUX: --job-name=ibs
#FLUX: -t=172800
#FLUX: --urgency=16

export MATLABPATH='$HOME/${PROJECT_FOLDER}/matlab'

PROJECT_FOLDER="IBS-2-development"
model=vstm
proc_id=${SLURM_ARRAY_TASK_ID}
method=ibs_2
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
echo "addpath('$SCRATCH/${PROJECT_FOLDER}/matlab/'); recover_theta('${model}','${method}',${proc_id},${Nsamples}); exit;" 
cat<<EOF | matlab -nodisplay
%job_id = str2num(strjoin(regexp('$proc_id','\d','match'), ''))
job_id = str2num('$proc_id')
recover_theta('vstm','ibs_2', job_id)
EOF
