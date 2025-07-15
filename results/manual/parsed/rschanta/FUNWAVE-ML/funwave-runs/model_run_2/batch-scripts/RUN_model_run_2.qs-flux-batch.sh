#!/bin/bash
#FLUX: --job-name=RUN_model_run_2
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	. /opt/shared/slurm/templates/libexec/openmpi.sh
	vpkg_require openmpi
	vpkg_require matlab
	fun_ex="/work/thsu/rschanta/RTS/funwave/v3.6/exec/FW-REG"
	echo "$fun_ex"
	input_file=$(get_input_dir "/lustre/scratch/rschanta/" "model_run_2" "$SLURM_ARRAY_TASK_ID")
	${UD_MPIRUN} "$fun_ex" "$input_file"
	run_compress_out_i /lustre/scratch/rschanta/ model_run_2 "$SLURM_ARRAY_TASK_ID" "/work/thsu/rschanta/RTS/"
