#!/bin/bash
#FLUX: --job-name=gloopy-plant-2036
#FLUX: -N=16
#FLUX: --urgency=16

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
