#!/bin/bash
#SBATCH --job-name=COMP_trial_4
#SBATCH --output=./trial_4/slurm_logs/COMP_out.out
#SBATCH --error=./trial_4/slurm_logs/COMP_err.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=thsu
#SBATCH --dependency=27478197

. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require matlab
args="'/lustre/scratch/rschanta/','trial_4'"
run_compress_out $args
rm -rf "/lustre/scratch/rschanta/trial_4/outputs-proc/"
rm -rf "/lustre/scratch/rschanta/trial_4/outputs-raw/"
