#!/bin/bash
#FLUX: --job-name=RUN_Run5_28
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

		## Load in bash functions and VALET packages
			. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
			vpkg_require openmpi
			vpkg_require matlab
		## Get input file name
			input_file=$(get_input_dir "/lustre/scratch/rschanta/" "Run5_28" "$SLURM_ARRAY_TASK_ID")
		## Run FUNWAVE
			${UD_MPIRUN} "/work/thsu/rschanta/RTS/funwave/v3.6/exec/FW-REG" "$input_file"
		## Compress outputs from run to single structure, calculate skew and asymmetry too
			run_compress_out_ska_i /lustre/scratch/rschanta/ Run5_28 "$SLURM_ARRAY_TASK_ID" "/work/thsu/rschanta/RTS/functions"
		## Delete raw files from run
			rm_raw_out_i /lustre/scratch/rschanta/ Run5_28 "$SLURM_ARRAY_TASK_ID"
