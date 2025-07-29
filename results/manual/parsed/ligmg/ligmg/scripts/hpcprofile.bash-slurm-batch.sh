#!/bin/bash
#SBATCH --account=m1489
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=regular
#SBATCH --constraint=ntasks-per-node=4

outfile="$1__${SLURM_JOB_NUM_NODES}_hpctoolkit"
module load hpctoolkit
srun hpcrun --event PAPI_TOT_CYC@10000 --event WALLCLOCK@100000 -o $outfile ./bin/main "${@:2}"
hpcprof -S main.hpcstruct -I src/'*' $outfile -o "$1_hpctoolkit_database"
