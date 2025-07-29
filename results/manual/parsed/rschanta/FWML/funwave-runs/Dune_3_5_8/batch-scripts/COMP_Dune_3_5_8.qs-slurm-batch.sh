#!/bin/bash
#SBATCH --job-name=COMP_Dune_3_5_8
#SBATCH --output=./Dune_3_5_8/slurm_logs/COMP_out.out
#SBATCH --error=./Dune_3_5_8/slurm_logs/COMP_err.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --dependency=27620481

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_compress_out /lustre/scratch/rschanta/ Dune_3_5_8 /work/thsu/rschanta/RTS/
	#rm -rf "/lustre/scratch/rschanta/Dune_3_5_8/outputs-proc/"
	rm -rf "/lustre/scratch/rschanta/Dune_3_5_8/outputs-raw/"
