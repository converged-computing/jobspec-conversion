#!/bin/bash
#FLUX: --job-name=ibs
#FLUX: -t=172800
#FLUX: --urgency=16

PROJECT_FOLDER="ibs-dev"
model=fourinarow
proc_id=${SLURM_ARRAY_TASK_ID}
method=fixed
Nsamples=100
if [ $method = "exact" ]; then
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}
else
    workdir=$SCRATCH/${PROJECT_FOLDER}/results/${model}/${method}${Nsamples}
fi
module purge
module load matlab/2018a
mkdir $SCRATCH/${PROJECT_FOLDER}/results
mkdir $SCRATCH/${PROJECT_FOLDER}/results/${model}
mkdir $workdir
cd $workdir
echo $model $method $Nsamples $proc_id
echo "addpath('$SCRATCH/${PROJECT_FOLDER}/matlab/'); recover_theta('${model}','${method}',${proc_id},${Nsamples}); exit;" | matlab -nodisplay
echo "Done"
