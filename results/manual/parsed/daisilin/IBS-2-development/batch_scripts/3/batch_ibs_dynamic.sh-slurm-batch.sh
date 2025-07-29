#!/bin/bash
#FLUX: --job-name=ibs_dynamic
#FLUX: -t=172800
#FLUX: --urgency=16

export MATLABPATH='$HOME/${PROJECT_FOLDER}/matlab'

PROJECT_FOLDER="IBS-2-development"
model=psycho
proc_id=${SLURM_ARRAY_TASK_ID}
method=ibs_dynamic_3
if [ $method = "exact" ]; then
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}/c_0.5
else
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}${Nsamples}/c_0.5
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
recover_theta('psycho','ibs_dynamic_3', job_id)
EOF
