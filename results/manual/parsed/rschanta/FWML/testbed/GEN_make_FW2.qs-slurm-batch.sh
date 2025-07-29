#!/bin/bash
#SBATCH --job-name=GEN_make_FW2
#SBATCH --output=mylog.out
#SBATCH --error=myfail.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require matlab
run_MATLAB_script "make_FW2.m"
