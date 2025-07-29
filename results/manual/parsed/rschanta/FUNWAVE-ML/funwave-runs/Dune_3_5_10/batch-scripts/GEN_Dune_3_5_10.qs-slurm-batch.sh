#!/bin/bash
#SBATCH --job-name=GEN_Dune_3_5_10
#SBATCH --output=./Dune_3_5_10/slurm_logs/GEN_out.out
#SBATCH --error=./Dune_3_5_10/slurm_logs/GEN_err.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=thsu

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_MATLAB_script "./Dune_3_5_10/Dune_3_5_10.m" "/work/thsu/rschanta/RTS/functions"
