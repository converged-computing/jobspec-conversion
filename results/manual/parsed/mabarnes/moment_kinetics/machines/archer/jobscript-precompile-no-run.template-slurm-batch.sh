#!/bin/bash
#SBATCH --account=ACCOUNT
#SBATCH --output=PRECOMPILEDIRslurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:00:00
#SBATCH --partition=serial
#SBATCH --qos=serial

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
echo "precompiling $(date)"
bin/julia --project -O3 --check-bounds=no precompile-no-run.jl
echo "finished! $(date)"
