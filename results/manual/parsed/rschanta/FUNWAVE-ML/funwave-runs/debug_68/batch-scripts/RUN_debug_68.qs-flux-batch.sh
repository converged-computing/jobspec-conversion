#!/bin/bash
#FLUX: --job-name=RUN_
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

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
