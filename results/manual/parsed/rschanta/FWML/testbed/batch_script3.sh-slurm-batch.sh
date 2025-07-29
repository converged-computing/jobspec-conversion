#!/bin/bash
#SBATCH --job-name=NewTitle
#SBATCH --output=mylog.out
#SBATCH --error=myfail.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

. /opt/shared/slurm/templates/libexec/openmpi.sh
. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require openmpi
vpkg_require matlab
	run_MATLAB_script "make_FW2.m"
