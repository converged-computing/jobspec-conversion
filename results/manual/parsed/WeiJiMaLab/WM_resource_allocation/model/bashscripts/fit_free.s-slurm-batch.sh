#!/bin/bash
#SBATCH --job-name=SWM_free
#SBATCH --output=SWM_free_%a.out
#SBATCH --mail-user=aspen.yoo@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=05:00:00

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
