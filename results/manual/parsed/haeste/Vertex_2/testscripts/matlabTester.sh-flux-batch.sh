#!/bin/bash
#FLUX: --job-name=matTest
#FLUX: -t=1800
#FLUX: --priority=16

echo Starting job
echo pwd
  module load MATLAB/2017a
  export MATLABPATH=~/vertex/hpcScripts
  matlab -nodesktop -nosplash -r testscript_rocket > output.txt;
echo Finishing job
