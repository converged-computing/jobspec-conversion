#!/bin/bash
#SBATCH --job-name=RUN_
#SBATCH --output=/work/thsu/rschanta/RTS/funwave-runs/debug_68/slurm_logs/RUN_out_%a.out
#SBATCH --error=/work/thsu/rschanta/RTS/funwave-runs/debug_68/slurm_logs/RUN_err_%a.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=standard
#SBATCH --array=1-4
#SBATCH --dependency=27850975

		## Load in bash functions and VALET packages
			export WORK_DIR=/work/thsu/rschanta/RTS/
			. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
			export_vars "/lustre/scratch/rschanta/" "/work/thsu/rschanta/RTS/" "debug_68" "rschanta@udel.edu"
			vpkg_require openmpi
			vpkg_require matlab
		## Get input file name
			input_file=$(get_input_dir "$SLURM_ARRAY_TASK_ID")
		## Run FUNWAVE
			${UD_MPIRUN} "/work/thsu/rschanta/RTS/funwave/v3.6/exec/FW-REG" "$input_file"
		## Compress outputs from run to single structure, calculate skew and asymmetry too
			run_comp_i "$SLURM_ARRAY_TASK_ID" "{'new_ska'}"
		## Delete raw files from run
			rm_raw_out_i "$SLURM_ARRAY_TASK_ID"
