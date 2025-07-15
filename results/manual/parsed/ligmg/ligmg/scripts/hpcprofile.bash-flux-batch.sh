#!/bin/bash
#FLUX: --job-name=anxious-peanut-butter-8605
#FLUX: --urgency=16

outfile="$1__${SLURM_JOB_NUM_NODES}_hpctoolkit"
module load hpctoolkit
srun hpcrun --event PAPI_TOT_CYC@10000 --event WALLCLOCK@100000 -o $outfile ./bin/main "${@:2}"
hpcprof -S main.hpcstruct -I src/'*' $outfile -o "$1_hpctoolkit_database"
