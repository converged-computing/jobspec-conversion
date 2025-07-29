#!/bin/bash
#SBATCH --account=ACCOUNT
#SBATCH --output=PRECOMPILEDIRslurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=skl_fua_dbg

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
echo "precompiling $(date)"
bin/julia --project -O3 --check-bounds=no precompile.jl
echo "finished! $(date)"
