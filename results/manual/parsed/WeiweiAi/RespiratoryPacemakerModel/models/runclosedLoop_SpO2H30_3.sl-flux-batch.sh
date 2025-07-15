#!/bin/bash
#FLUX: --job-name=closedLoop_SpO2H30_3
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --urgency=16

export model_name='closedLoop_SpO2H'
export para_name='parL3'
export root_path='/nesi/nobackup/uoa00596/lungPacemaker/" # Everything happens in here. Having this a variable makes it easy to move where you run your jobs. '
export script_path='${root_path}model/"  #This is where all the scripts are.'
export data_path='${root_path}data/$SLURM_JOB_NAME"  #This is where all the scripts are.'
export working_path='${root_path}Working/$SLURM_JOB_NAME/run_${SLURM_ARRAY_TASK_ID}/" #This the jobs put their individual files that need to be kept seperate.'
export TMPDIR='${working_path} #Stop matlab temp files clashing.'

export model_name="closedLoop_SpO2H"
export para_name="parL3"
export root_path="/nesi/nobackup/uoa00596/lungPacemaker/" # Everything happens in here. Having this a variable makes it easy to move where you run your jobs. 
export script_path="${root_path}model/"  #This is where all the scripts are.
export data_path="${root_path}data/$SLURM_JOB_NAME"  #This is where all the scripts are.
mkdir -vp ${data_path}  #This will create the directory for the data
export working_path="${root_path}Working/$SLURM_JOB_NAME/run_${SLURM_ARRAY_TASK_ID}/" #This the jobs put their individual files that need to be kept seperate.
mkdir -vp ${working_path}  #This will create the directory and move you into it.
cp ${script_path}${model_name}.mdl  ${working_path}${model_name}${SLURM_ARRAY_TASK_ID}.mdl  		#This will take a copy of the simulink model into the running directory.
cp ${script_path}${para_name}.mat   ${working_path}${para_name}.mat  		#This will take a copy of the parameter into the running directory.
export TMPDIR=${working_path} #Stop matlab temp files clashing.
module load MATLAB/2019b
matlab -nojvm -nodisplay -r "run('${script_path}runClosedLoopSo2_30_3.m');exit;"
rm -r ${working_path}
