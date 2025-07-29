#!/bin/bash
#SBATCH --job-name=senseDyn
#SBATCH --account=carney-ashenhav-condo
#SBATCH --output=logs/senseDyn_%J.txt
#SBATCH --mail-user=hritz@brown.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128GB
#SBATCH --time=00:30:00

module load matlab/R2019a
echo 'started at:'
date
echo; echo; echo; echo;
matlab-threaded –nodisplay -nodesktop -r "launch_parpool(12); senseDyn"
echo; echo; echo; echo;
echo 'finished at:'
date
