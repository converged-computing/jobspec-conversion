#!/bin/bash
#SBATCH --account=100humans
#SBATCH --output=cluster_logs/slurm-%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

COHORT=$1
umask 002
mkdir -p cohorts/${COHORT}/
LOCKFILE=cohorts/${COHORT}/process_cohort.lock
lockfile -r 0 ${LOCKFILE} || exit 1
trap "rm -f ${LOCKFILE}; exit" SIGINT SIGTERM ERR EXIT
source workflow/variables.env
snakemake \
    --config cohort=${COHORT} \
    --nolock \
    --profile workflow/profiles/slurm \
    --snakefile workflow/process_cohort.smk
