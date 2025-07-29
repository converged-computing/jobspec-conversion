#!/bin/bash
#SBATCH --account=<CHANGE>
#SBATCH --output=out.txt
#SBATCH --error=err.txt
#SBATCH --mail-user=<CHANGE>
#SBATCH --mail-type=END
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=600000mb
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=simulated_minimal

export PMIX_MCA_gds='hash'

export PMIX_MCA_gds=hash
module restore gnu > /dev/null
DATASET="simulated"
EXEC="ft-restore-raxml-minimal"
NAME="p$SLURM_JOB_NUM_NODES"
SEED=0
PREFIX_DIR="$(pwd)"
REPEATS=(0 1 2 3 4 5 6 7 8 9)
FAIL_EVERY=100000
MAX_FAILURES=0
source ../run_with_restore.sh
