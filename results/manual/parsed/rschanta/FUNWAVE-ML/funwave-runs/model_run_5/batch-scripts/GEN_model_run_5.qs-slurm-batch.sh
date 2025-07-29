#!/bin/bash
#SBATCH --job-name=GEN_model_run_5
#SBATCH --output=./model_run_5/slurm_logs/GEN_out.out
#SBATCH --error=./model_run_5/slurm_logs/GEN_err.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

	## Load in bash functions and VALET packages
		. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
		vpkg_require matlab
	## Run Generation Script
		run_MATLAB_script "./model_run_5/model_run_5.m" "/work/thsu/rschanta/RTS/functions"
