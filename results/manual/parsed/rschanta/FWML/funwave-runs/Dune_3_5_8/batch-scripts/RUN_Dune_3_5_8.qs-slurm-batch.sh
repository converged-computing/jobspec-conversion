#!/bin/bash
#SBATCH --job-name=RUN_Dune_3_5_8
#SBATCH --output=./Dune_3_5_8/slurm_logs/RUN_out_%a.out
#SBATCH --error=./Dune_3_5_8/slurm_logs/RUN_err_%a.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=standard
#SBATCH --array=1-2
#SBATCH --dependency=27620480

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	. /opt/shared/slurm/templates/libexec/openmpi.sh
	vpkg_require openmpi
	vpkg_require matlab
	fun_ex="/work/thsu/rschanta/RTS/funwave/v3.6/exec/FW-COUP"
	echo "$fun_ex"
	input_file=$(get_input_dir "/lustre/scratch/rschanta/" "Dune_3_5_8" "$SLURM_ARRAY_TASK_ID")
	${UD_MPIRUN} "$fun_ex" "$input_file"
	run_compress_out_ska_i /lustre/scratch/rschanta/ Dune_3_5_8 "$SLURM_ARRAY_TASK_ID" "/work/thsu/rschanta/RTS/"
