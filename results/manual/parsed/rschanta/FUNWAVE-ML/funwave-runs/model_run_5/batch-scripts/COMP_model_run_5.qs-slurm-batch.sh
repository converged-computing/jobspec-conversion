#!/bin/bash
#SBATCH --job-name=COMP_model_run_5
#SBATCH --output=./model_run_5/slurm_logs/COMP_out.out
#SBATCH --error=./model_run_5/slurm_logs/COMP_err.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --dependency=27804911

		## Load in bash functions and VALET packages
			. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
			vpkg_require matlab
		## Compress skew and asymmetry
			run_compress_ska /lustre/scratch/rschanta/ model_run_5 /work/thsu/rschanta/RTS/functions
