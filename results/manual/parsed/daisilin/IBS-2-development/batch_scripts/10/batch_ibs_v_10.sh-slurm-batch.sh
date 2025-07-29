#!/bin/bash
#SBATCH --job-name=ibs_vstm
#SBATCH --output=ibs2_%j.out
#SBATCH --mail-user=xl1005@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --array=1-80

export MATLABPATH='$HOME/${PROJECT_FOLDER}/matlab'

PROJECT_FOLDER="IBS-2-development"
model=vstm
proc_id=${SLURM_ARRAY_TASK_ID}
alpha=1
method=ibs_10
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
recover_theta('vstm','ibs_10',alpha,job_id)
EOF
