#!/bin/bash
#SBATCH --job-name=matTest
#SBATCH --account=mknr
#SBATCH --output=matest.out
#SBATCH --error=matest.err
#SBATCH --mail-user=frances.hutchings@ncl.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500
#SBATCH --time=00:30:00
#SBATCH --chdir=~/vertex/hpcScripts

echo Starting job
echo pwd
  module load MATLAB/2017a
  export MATLABPATH=~/vertex/hpcScripts
  matlab -nodesktop -nosplash -r testscript_rocket > output.txt;
echo Finishing job
