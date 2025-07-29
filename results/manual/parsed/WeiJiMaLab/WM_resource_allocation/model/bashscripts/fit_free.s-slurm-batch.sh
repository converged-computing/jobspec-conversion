#!/bin/bash
#FLUX: --job-name=SWM_free
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load matlab/2016b
cat<<EOF | matlab -nodisplay
addpath(genpath('/home/ay963/matlab-scripts'))
addpath(genpath('/home/ay963/spatialWM'))
model = 2;
expnumber = 2;
blah = num2str($SLURM_ARRAY_TASK_ID);
runlistidx = str2double(blah(1));
subjnum = str2double(blah(2:end));
runmax = 50;
runlist = runlistidx:5:(45+runlistidx);
fit_parameters(model,subjnum,runlist,runmax,[],expnumber)
EOF
