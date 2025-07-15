#!/bin/bash
#FLUX: --job-name=bloated-gato-4450
#FLUX: --priority=16

outfile="$1__${SLURM_JOB_NUM_NODES}_hpctoolkit"
module load hpctoolkit
srun hpcrun --event PAPI_TOT_CYC@10000 --event WALLCLOCK@100000 -o $outfile ./bin/main "${@:2}"
hpcprof -S main.hpcstruct -I src/'*' $outfile -o "$1_hpctoolkit_database"
